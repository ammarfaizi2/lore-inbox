Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267633AbTBEAyL>; Tue, 4 Feb 2003 19:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267636AbTBEAyL>; Tue, 4 Feb 2003 19:54:11 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:56841 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S267633AbTBEAyL>; Tue, 4 Feb 2003 19:54:11 -0500
Date: Wed, 5 Feb 2003 02:03:38 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: "Robert P. J. Day" <rpjday@mindspring.com>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: cleanup of filesystems menu
In-Reply-To: <Pine.LNX.4.44.0302041512090.16603-100000@dell>
Message-ID: <Pine.LNX.4.44.0302050148490.32518-100000@serv>
References: <Pine.LNX.4.44.0302041512090.16603-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 4 Feb 2003, Robert P. J. Day wrote:

>   http://www.xenotime.net/linux/kconfig/kconfig-fs-2.5.59b.patch
> 
> currently, it still has leading asterisks in front of the
> config entries to support editing in emacs outline mode, 
> but future patches will have these removed.

Hmm, you are abusing comments somewhat, please don't use "<<<< ... >>>>"
If there is a large group of options it should be in it's own submenu or 
I'd rather add something else to group these options logically together.
Maybe it's better to just sort the options logically in the first step and 
do the rest separately.

bye, Roman

