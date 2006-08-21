Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751232AbWHUWYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbWHUWYN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 18:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbWHUWYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 18:24:13 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:24335 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751232AbWHUWYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 18:24:12 -0400
Date: Tue, 22 Aug 2006 00:24:12 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [2.6 patch] re-add -ffreestanding
Message-ID: <20060821222412.GS11651@stusta.de>
References: <20060821212154.GO11651@stusta.de> <20060821232444.9a347714.ak@suse.de> <20060821214636.GP11651@stusta.de> <20060822000903.441acb64.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060822000903.441acb64.ak@suse.de>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2006 at 12:09:03AM +0200, Andi Kleen wrote:
> On Mon, 21 Aug 2006 23:46:36 +0200
> Adrian Bunk <bunk@stusta.de> wrote:
> 
> > On Mon, Aug 21, 2006 at 11:24:44PM +0200, Andi Kleen wrote:
> > > On Mon, 21 Aug 2006 23:21:54 +0200
> > > Adrian Bunk <bunk@stusta.de> wrote:
> > > 
> > > > I got the following compile error with gcc 4.1.1 when trying to compile 
> > > > kernel 2.6.18-rc4-mm2 for m68k:
> > > 
> > > I object to this change. -ffreestanding shouldn't be forced on everybody
> > 
> > Why?
> 
> Because -ffreestanding does the the wrong thing(tm) for the x86-64 
> string implementation (which I plan to extend at some point to i386
> too BTW). Don't argue with it -- what counts is not the name,
> but the semantics.

It disables the automatic usage of builtins which is OK.

Which other semantics does it have that is causing problems?

> -Andi

cu
Adrian

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli

