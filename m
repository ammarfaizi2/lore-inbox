Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbWE2I1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbWE2I1A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 04:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbWE2I1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 04:27:00 -0400
Received: from ns.suse.de ([195.135.220.2]:37765 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750768AbWE2I07 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 04:26:59 -0400
From: Neil Brown <neilb@suse.de>
To: Nikita Danilov <nikita@clusterfs.com>
Date: Mon, 29 May 2006 18:26:47 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17530.45127.92580.684010@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.16.18 - spelling fix
Newsgroups: gmane.linux.kernel
In-Reply-To: message from Nikita Danilov on Monday May 29
References: <Pine.LNX.4.64.0605272016520.28903@p34>
	<17530.11036.427239.812677@cse.unsw.edu.au>
	<17530.42626.693182.834140@gargle.gargle.HOWL>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday May 29, nikita@clusterfs.com wrote:
> Neil Brown writes:
>  > On Saturday May 27, jpiszcz@lucidpixels.com wrote:
>  > > I was experimenting with Linux SW raid today and found a spelling error 
>  > > when reading the help menus...
>  > > 
>  > > Patch attached, not sure if this is the right place to send it or if 
>  > > patches go to Andrew Morton (misc ones like this)...
>  > 
>  > Thanks....
>  > but more helpful than a spelling fix would be a chunk of elisp that I
>  > could stick in my .emacs, which would automatically turn on flyspell
>  > mode in Kconfig files, and inside comments in .c and .h files.
> 
> (defun linux-c-mode ()
>   ...
>   (flyspell-prog-mode)
>   ...)
> 

Seems easy enough.... doesn't work for me :-(

Further exploration shows that I need font-lock mode enabled for it to
highlight speeling errors for me, and I never could get used to seeing
my C code look like a Disco.

It seems that flyspell-prog-mode absolutely requires font-lock as it
uses the font-lock tags to detect which text to spell check.

So I guess I need to tell font-lock that all the different text types
should be displayed in the same font.

Why is it never easy?

Thanks.

NeilBrown
