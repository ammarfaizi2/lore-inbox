Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280754AbRKGDuJ>; Tue, 6 Nov 2001 22:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280756AbRKGDtt>; Tue, 6 Nov 2001 22:49:49 -0500
Received: from rj.sgi.com ([204.94.215.100]:31366 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S280754AbRKGDtc>;
	Tue, 6 Nov 2001 22:49:32 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: "Eric W. Biederman" <ebiederman@lnxi.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.14-pre8 Alt-SysRq-[TM] failure during lockup... 
In-Reply-To: Your message of "Tue, 06 Nov 2001 11:10:54 -0800."
             <3BE835BE.DF4A98FA@osdl.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 07 Nov 2001 14:49:23 +1100
Message-ID: <26854.1005104963@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Nov 2001 11:10:54 -0800, 
"Randy.Dunlap" <rddunlap@osdl.org> wrote:
>It bugged me because I often use the "debug" boot parameter
>to set console_loglevel to 10, but all of a sudden it had been
>set back to 6 IIRC!  And right now on one of my test
>systems it is set to 0 according to /proc/sys/kernel/printk,
>although _I_ didn't ask for it to be changed to 0, and
>I haven't been able to find what's changing it to 0, since
>it was 10 during init/main.c.

Any chance that console_loglevel, default_message_loglevel,
minimum_console_loglevel and default_console_loglevel are not together
in memory?  I see that the patch from Jesper Juhl <juhl@eisenstein.dk>
to fix this bug has not gone into the kernel yet.

