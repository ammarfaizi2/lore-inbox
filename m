Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286841AbRLWJRx>; Sun, 23 Dec 2001 04:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286843AbRLWJRn>; Sun, 23 Dec 2001 04:17:43 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:32087 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S286841AbRLWJRb>; Sun, 23 Dec 2001 04:17:31 -0500
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: dcinege@psychosis.com, otto.wyss@bluewin.ch,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Booting a modular kernel through a multiple streams file
In-Reply-To: <59885C5E3098D511AD690002A5072D3C42D81C@orsmsx111.jf.intel.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 23 Dec 2001 02:15:52 -0700
In-Reply-To: <59885C5E3098D511AD690002A5072D3C42D81C@orsmsx111.jf.intel.com>
Message-ID: <m1r8pmqotz.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Grover, Andrew" <andrew.grover@intel.com> writes:

> > From: ebiederm@xmission.com [mailto:ebiederm@xmission.com]
> > > Basically what Grub does is loads the kernel modules from disk
> > > into memory, and 'tells' the kernel the memory location to load
> > > them from, very similar to how an initrd file is loaded. The problem
> > > is Linux, is not MBS compilant and doesn't know to look for and load
> > > the modules. 
> > 
> > So tell me how you make an MBS compliant alpha kernel again?
> 
> 1) Someone writes a MBS spec chapter for Alpha

Nope it isn't that simple.  Multiboot doesn't extend gracefully at all,
not to multiple architectures, not to new parameters, not to multiple
vendors.   If you do extend it you get a real mess.

Which is why it is not good to adopt.  

> 2) Someone implements it.
> 
> Any volunteers? (Eric? ;-))

I've looked and I'm not going there.  Multiboot is just plain nasty,
and quite poorly specified as well.

I'll do something better but not that.  In fact I have already started...

> It's all about scratching an itch, right? Things don't become cross-platform
> by themselves. Linux started out 386-only, after all.

GRUB allows some very neat things and it allows for it with the
multiboot stuff.  And everyone seems to assume that because what you
can do with GRUB is good, multiboot must be good as well.  But have
you ever wondered why no other bootloader implementor was interested?

Eric
