Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274368AbRKNSp7>; Wed, 14 Nov 2001 13:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274752AbRKNSpt>; Wed, 14 Nov 2001 13:45:49 -0500
Received: from maild.telia.com ([194.22.190.101]:35801 "EHLO maild.telia.com")
	by vger.kernel.org with ESMTP id <S274368AbRKNSpj>;
	Wed, 14 Nov 2001 13:45:39 -0500
Message-Id: <200111141845.fAEIjba23279@d1o849.telia.com>
Content-Type: text/plain; charset=US-ASCII
From: Jakob Kemi <jakob.kemi@telia.com>
To: linux-kernel@vger.kernel.org
Subject: Parport broken in >= 2.4.11
Date: Wed, 14 Nov 2001 19:45:27 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a IEEE1284 parport webcam (using the w9966 drivers).
In 2.4.10 everyhing is fine but in 2.4.11 through 2.4.15-pre4 parport_read() 
always fails and return 0 bytes. w9966.c has remained unchanged throughout.
What kind of changes has the parport drivers gone through? Has the parport 
interface to kernel drivers changed somehow?

	/Jakob
