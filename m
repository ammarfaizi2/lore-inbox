Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129934AbQJ1OdP>; Sat, 28 Oct 2000 10:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130268AbQJ1OdF>; Sat, 28 Oct 2000 10:33:05 -0400
Received: from [195.180.174.143] ([195.180.174.143]:12160 "EHLO
	ghanima.neukum.org") by vger.kernel.org with ESMTP
	id <S129934AbQJ1Ocx>; Sat, 28 Oct 2000 10:32:53 -0400
From: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
Date: Sat, 28 Oct 2000 16:31:35 +0200
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Subject: question on SMP and read()/write()
MIME-Version: 1.0
Message-Id: <00102816313507.00773@ghanima>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've noticed that sys_read() and sys_write() don't grab the big kernel lock.
As file descriptors may be shared, must device drivers provide SMP safe
read() and write() methods ?

	TIA
		Oliver
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
