Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280255AbRKIWpD>; Fri, 9 Nov 2001 17:45:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280257AbRKIWom>; Fri, 9 Nov 2001 17:44:42 -0500
Received: from b0rked.dhs.org ([216.99.196.11]:36480 "HELO b0rked.dhs.org")
	by vger.kernel.org with SMTP id <S280255AbRKIWok>;
	Fri, 9 Nov 2001 17:44:40 -0500
Date: Fri, 9 Nov 2001 14:44:35 -0800 (PST)
From: Chris Vandomelen <chrisv@b0rked.dhs.org>
X-X-Sender: <chrisv@linux>
To: Luigi Genoni <kernel@Expansa.sns.it>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: binfmt_misc and 2.4.13|14
In-Reply-To: <Pine.LNX.4.33.0111092218100.23632-100000@Expansa.sns.it>
Message-ID: <Pine.LNX.4.31.0111091443100.6159-100000@linux>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 9 Nov 2001, Luigi Genoni wrote:

> HI,
> Has it been noticed that loading binfmt_misc module with 2.4.13|14
> kernel the procfs entries
> /proc/sys/fs/binfmt_misc/register
> /proc/sys/fs/binfmt_misc/status
> are not created anymore?
>
> so the directory /proc/sys/fs/binfmt_misc is emtpy, and I do not know how
> to manage this module.
> Some hints?

mount -t binfmt_misc none /proc/sys/fs/binfmt_misc

Or add to /etc/fstab:

none	/proc/sys/fs/binfmt_misc	binfmt_misc	defaults	0 0

Chris

