Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264475AbRGCOpu>; Tue, 3 Jul 2001 10:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264482AbRGCOpk>; Tue, 3 Jul 2001 10:45:40 -0400
Received: from web4201.mail.yahoo.com ([216.115.104.134]:14095 "HELO
	web4201.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S264475AbRGCOpd>; Tue, 3 Jul 2001 10:45:33 -0400
Message-ID: <20010703144532.11007.qmail@web4201.mail.yahoo.com>
Date: Tue, 3 Jul 2001 16:45:32 +0200 (CEST)
From: =?iso-8859-1?q?Guillaume=20Lancelin?= <guillaumelancelin@yahoo.es>
Subject: Memory access
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Writing a device driver for a IO card, I have the following message from
the kernel:
Unable to handle kernel paging request at virtual address 000d0804.
[then it gives the register values]
Segmentation fault."

This address (0xd0804) is the location of a "mailbox" reserved by the IO
card, and from which commands are passed to the card.

My question: is the kernel using or protecting this area of the memory,
and is there a way to deprotect it??? (how dangerous!)

Thanks
Guillaume



_______________________________________________________________
Do You Yahoo!?
Yahoo! Messenger: Comunicación instantánea gratis con tu gente -
http://messenger.yahoo.es
