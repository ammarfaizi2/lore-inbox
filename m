Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262042AbREaNxl>; Thu, 31 May 2001 09:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263096AbREaNxc>; Thu, 31 May 2001 09:53:32 -0400
Received: from zeus.kernel.org ([209.10.41.242]:51865 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S262042AbREaNxY>;
	Thu, 31 May 2001 09:53:24 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ben Twijnstra <bentw@chello.nl>
To: linux-kernel@vger.kernel.org
Subject: Sound card lockup on 2.4.5-ac4 and -ac5
Date: Thu, 31 May 2001 15:47:39 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01053115473900.00941@beastie>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

As of 2.4.5-ac4 (maybe -ac3 too), my sound card (a cs46xx) has stopped 
working. Looks like there's something wrong with the interrupt handling code 
because the device remains busy, I get weird lockups after having run and 
^C-ed sndconfig. Also, when I look at /proc/interrupts after sndconfig, the 
IRQ for the sound card seems stuck at 0.

I've seen changes in the driver code, but they don't seem to have much to do 
with the interrupt handling.

Any ideas?

