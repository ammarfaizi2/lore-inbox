Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280891AbRKLR4T>; Mon, 12 Nov 2001 12:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280892AbRKLR4J>; Mon, 12 Nov 2001 12:56:09 -0500
Received: from air-1.osdl.org ([65.201.151.5]:15364 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S280891AbRKLR4C>;
	Mon, 12 Nov 2001 12:56:02 -0500
Date: Mon, 12 Nov 2001 09:55:00 -0800 (PST)
From: <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Keith Owens <kaos@ocs.com.au>
cc: "Eric W. Biederman" <ebiederman@lnxi.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.14-pre8 Alt-SysRq-[TM] failure during lockup... 
In-Reply-To: <26854.1005104963@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.33L2.0111120953380.6621-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Nov 2001, Keith Owens wrote:

| On Tue, 06 Nov 2001 11:10:54 -0800,
| "Randy.Dunlap" <rddunlap@osdl.org> wrote:
| >It bugged me because I often use the "debug" boot parameter
| >to set console_loglevel to 10, but all of a sudden it had been
| >set back to 6 IIRC!  And right now on one of my test
| >systems it is set to 0 according to /proc/sys/kernel/printk,
| >although _I_ didn't ask for it to be changed to 0, and
| >I haven't been able to find what's changing it to 0, since
| >it was 10 during init/main.c.
|
| Any chance that console_loglevel, default_message_loglevel,
| minimum_console_loglevel and default_console_loglevel are not together
| in memory?  I see that the patch from Jesper Juhl <juhl@eisenstein.dk>
| to fix this bug has not gone into the kernel yet.
|

That would have been an acceptable analysis and solution to me,
but alas, I checked, and that's not the problem.

Thanks.
-- 
~Randy

