Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293050AbSB0Xiy>; Wed, 27 Feb 2002 18:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293063AbSB0XiI>; Wed, 27 Feb 2002 18:38:08 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:60053 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id <S293055AbSB0Xg7>; Wed, 27 Feb 2002 18:36:59 -0500
To: linux-kernel@vger.kernel.org
From: Jonathan Hudson <jonathan@daria.co.uk>
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
x-no-productlinks: yes
X-Comment-To: Alan Cox
In-Reply-To: <fa.c7mcedv.1a3esq4@ifi.uio.no> <fa.g5iqv0v.11magge@ifi.uio.no>
Subject: Re: Linux 2.4.19pre1-ac1
X-Newsgroups: fa.linux.kernel
Content-Type: text/plain; charset=iso-8859-1
NNTP-Posting-Host: daria.co.uk
Message-ID: <6924.3c7d6d97.1d4ab@trespassersw.daria.co.uk>
Date: Wed, 27 Feb 2002 23:36:55 GMT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <fa.g5iqv0v.11magge@ifi.uio.no>,
	Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
AC> 
AC> What compiler firstly, and what I/O subsystem. Are you using highmem,
AC> did you build from a clean tree ?
AC> 

For the pre1-ac1 problems I reported, 2.95.4 (the Debian one),
reisferfs on IDE, no highmem. The tree has been patched ('official 2.4pre/rc
+ ac only) for many versions.

Now reverted to a clean 2.4.18 (full tarball) +pre1 after the disk
hard-locked in the middle patching, requiring a power cycle.  

I'm currently repeating the tests on pre1-ac2, __initial__ indications
are that the problem does NOT happen, so maybe it was the shm.
