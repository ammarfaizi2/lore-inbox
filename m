Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289374AbSAKDcq>; Thu, 10 Jan 2002 22:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289111AbSAKDcg>; Thu, 10 Jan 2002 22:32:36 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:40876
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S289374AbSAKDc3>; Thu, 10 Jan 2002 22:32:29 -0500
Date: Thu, 10 Jan 2002 20:32:12 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Torrey Hoffman <torrey.hoffman@myrio.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
        felix-dietlibc@fefe.de, andersen@codepoet.org
Subject: Re: [RFC] klibc requirements, round 2
Message-ID: <20020111033212.GI13931@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <D52B19A7284D32459CF20D579C4B0C0211CB2C@mail0.myrio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D52B19A7284D32459CF20D579C4B0C0211CB2C@mail0.myrio.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2002 at 05:50:52PM -0800, Torrey Hoffman wrote:
> Tom Rini wrote:
> > On Thu, Jan 10, 2002 at 03:18:49PM -0800, Greg KH wrote:
> ... 
> > > 	- image viewer
> > > 	- mkreiserfs
> > 
> > I think these are examples of misunderstanding what initramfs _can do_
> > with what we (might) need a klibc to do.  
> ...
> > These programs _might_ compile with a klibc, but I wouldn't 
> > worry about
> > it.  uClibc is what should be used for many of these custom 
> > applications
> 
> Well, as the person who first mentioned mkreiserfs and the like,
> I agree with you.  For the majority of systems out there which 
> aren't using initrd now, a minimal klibc for an unmodified 
> initramfs makes sense.

Okay.

> My concern is with the minority who are using initrd, and in
> some cases a very customized initrd.  

Right.  And moving that very customized initrd over to an initramfs
should be painless, once the kinks/bugs are worked out of the yet-to-be
created programs that exist in the kernel now.

> The important thing, I think, is that it should be easy for
> less-than-guru level hackers to add programs to the initramfs,
> even if the program they want can't be linked with klibc.
> 
> This really comes down to: What will the build process be for
> these initramfs images?

It's a cpio archive, occording to the draft spec hpa posted.

> By the way, is initramfs intended to supercede initrd, or will 
> they co-exist?  

I _think_ co-exist.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
