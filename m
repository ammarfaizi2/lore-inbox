Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268609AbRGYSpT>; Wed, 25 Jul 2001 14:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268611AbRGYSpI>; Wed, 25 Jul 2001 14:45:08 -0400
Received: from web14801.mail.yahoo.com ([216.136.224.217]:21776 "HELO
	web14801.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S268609AbRGYSox>; Wed, 25 Jul 2001 14:44:53 -0400
Message-ID: <20010725184459.95230.qmail@web14801.mail.yahoo.com>
Date: Wed, 25 Jul 2001 11:44:59 -0700 (PDT)
From: Sumit Bhardwaj <bsumit3@yahoo.com>
Reply-To: bsumit3@users.sourceforge.net
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

I tried to compile linux 2.4.5 with gcc-3.0. It gave
the following error

kernel/sched.c : 'xtime' definition clash
In file include/linux/timer.h: line no. 540

after making the declaration

extern volatile struct xtime;

things worked fine.


__________________________________________________
Do You Yahoo!?
Make international calls for as low as $.04/minute with Yahoo! Messenger
http://phonecard.yahoo.com/
