Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277330AbRJOIBt>; Mon, 15 Oct 2001 04:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277331AbRJOIBj>; Mon, 15 Oct 2001 04:01:39 -0400
Received: from web13107.mail.yahoo.com ([216.136.174.152]:24328 "HELO
	web13107.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S277330AbRJOIB3>; Mon, 15 Oct 2001 04:01:29 -0400
Message-ID: <20011015080201.55034.qmail@web13107.mail.yahoo.com>
Date: Mon, 15 Oct 2001 01:02:01 -0700 (PDT)
From: Chris Rankin <rankincj@yahoo.com>
Subject: Opening /dev/tty from /dev/vc/6 gives /dev/vc/1 instead?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have noticed that the login program on my Linux
2.4.x boxes is sometimes putting the "Password:"
prompt on vc/1, even if I'm trying to login to vc/6.
This login program is from the "shadow password"
utilities, whose password-authentication routine
always gets the current terminal from /dev/tty rather
than trusting the inherited one.

I have only noticed this problem on the first attempt
to login to a vc after a reboot, and I have noticed it
on both a UP, 64MB, non-devfs and an SMP, 1.25 GB
devfs box. 

I haven't tested any of the -ac kernels, but I have
observed this on at least 2.4.7, 2.4.10, 2.4.11 (ahem)
and 2.4.12.
Cheers,
Chris


__________________________________________________
Do You Yahoo!?
Make a great connection at Yahoo! Personals.
http://personals.yahoo.com
