Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129027AbRBNG6o>; Wed, 14 Feb 2001 01:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129032AbRBNG6d>; Wed, 14 Feb 2001 01:58:33 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:1313 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129027AbRBNG6R>; Wed, 14 Feb 2001 01:58:17 -0500
Date: Wed, 14 Feb 2001 00:58:13 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
To: Willy Tarreau <wtarreau@free.fr>
cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: incremental patches for 2.4*-ac* kernels
In-Reply-To: <982133270.3a8a2a1644394@imp.free.fr>
Message-ID: <Pine.LNX.3.96.1010214005431.24061Q-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Feb 2001, Willy Tarreau wrote:
> I think that most of us using modems begin to experience a little pain in
> downloading latest Alan's patches since they're becoming to be really big (and
> interesting).
> 
> Since I have an occasionnal access to a system equipped with a good line, I
> began to make incremental patches for these kernels. These patches are about
> 60 kb instead of nearly 2 Mb. Those who are interested can download them from
> this url :
> 
>    http://www-miaif.lip6.fr/willy/pub/linux-patches/ac/

Cool.

FWIW, people can also download Alan's patches and Linus' pre-patches
from my 'gkernel' CVS at sourceforge.  Instructions for anoncvs are on
the SourceForge home page, near the bottom:
http://sourceforge.net/projects/gkernel/

Check out module 'linux_2_2' or 'linux_2_4'.  You --MUST-- use a branch
tag when checking out.  Branch tags are named based on kernel version,
ie.:

	REL_2_4_1_ac11
	REL_2_2_19_pre10
	REL_2_4_2_pre3

Using CVS allows easy diff'ing of the full kernel
> cvs -z9 rdiff -u -r REL_2_4_1_ac10 -r REL_2_4_1_ac11 linux_2_4

or just a part of the tree
> cvs -z9 rdiff -u -r REL_2_4_1_ac10 -r REL_2_4_1_ac11 linux_2_4/drivers/net

(as a side note, if you s/REL/hack/ in the above tag names, you get my
public CVS tree...)

Any questions, or anyone wanting my CVS import/merge scripts, just let
me know.

	Jeff



