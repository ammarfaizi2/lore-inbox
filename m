Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267697AbTAMA0X>; Sun, 12 Jan 2003 19:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267696AbTAMA0V>; Sun, 12 Jan 2003 19:26:21 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:6418 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S267688AbTAMAY7>; Sun, 12 Jan 2003 19:24:59 -0500
Message-ID: <3E220770.734F8553@linux-m68k.org>
Date: Mon, 13 Jan 2003 01:25:20 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Clean up refcounting on filesystems
References: <20030111110623.08E2B2C0BC@lists.samba.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Rusty Russell wrote:

>         This gets rid of the hacky module count reentry, by holding a
> reference count per mount, rather than per superblock.  The additional
> field to struct vfsmount is slightly gratuitous, but nice and
> explicit.  Minor collateral cleanups.

I hoped Al would answer, but so I have to ask again.
What are you trying to fix with this? AFAICT module init races are still
there, how do you want to fix them and how will this patch help?
Rusty, could I please, please, please (with sugar on top) get an answer
to any of my questions from you?

bye, Roman
