Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135711AbRDSU4T>; Thu, 19 Apr 2001 16:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135704AbRDSUzf>; Thu, 19 Apr 2001 16:55:35 -0400
Received: from wisdn-0.gus.net ([208.146.196.17]:23568 "EHLO
	cerberus.stardot-tech.com") by vger.kernel.org with ESMTP
	id <S135713AbRDSUyL>; Thu, 19 Apr 2001 16:54:11 -0400
Date: Thu, 19 Apr 2001 13:53:56 -0700 (PDT)
From: Jim Treadway <jim@stardot-tech.com>
To: "Eric S. Raymond" <esr@thyrsus.com>
cc: <linux-kernel@vger.kernel.org>, <kbuild-devel@lists.sourceforge.net>
Subject: Re: Cross-referencing frenzy
In-Reply-To: <20010419133347.A3515@thyrsus.com>
Message-ID: <Pine.LNX.4.33.0104191351290.731-100000@cerberus.stardot-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Apr 2001, Eric S. Raymond wrote:

> Andreas Dilger <adilger@turbolinux.com>:
> > However, I'm not sure that your reasoning for removing these is correct.
> > For example, one symbol that I saw was CONFIG_EXT2_CHECK, which is code
> > that used to be enabled in the kernel, but is currently #ifdef'd out with
> > the above symbol.  When Ted changed this, he wasn't sure whether we would
> > need the code again in the future.  I enable it sometimes when I'm doing
> > ext2 development, but it may not be worthy of a separate config option
> > that 99.9% of people will just be confused about.
>
> I think things like that don't belong in the CONFIG_ namespace to begin
> with.

How about CONFIG_DEBUG_ or just simply DEBUG_?  You could even have a CML
add-on or switch that configures the various DEBUG_ options (but perhaps
thats a bit too strange).


