Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265781AbSJTFn0>; Sun, 20 Oct 2002 01:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265782AbSJTFn0>; Sun, 20 Oct 2002 01:43:26 -0400
Received: from zeus.kernel.org ([204.152.189.113]:3238 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S265781AbSJTFnZ>;
	Sun, 20 Oct 2002 01:43:25 -0400
Date: Sun, 20 Oct 2002 05:45:13 +0100
From: John Levon <levon@movementarian.org>
To: Matthew Wilcox <willy@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] work around duff ABIs
Message-ID: <20021020044513.GA54778@compsoc.man.ac.uk>
References: <20021020053147.C5285@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021020053147.C5285@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 20, 2002 at 05:31:47AM +0100, Matthew Wilcox wrote:

> *sigh*.  i hate this kind of bullshit.  please, don't anyone ever try
> to pass 64-bit args through the syscall interface again.

I was about to do exactly that ...

> + * LFS versions of truncate are only needed on 32 bit machines.  PA-RISC
> + * and MIPS ABIs specify 64-bit alignment for 64-bit quantities, but glibc
> + * ignores this and passes 64-bit quantities in misaligned registers.

Isn't glibc broken ?

regards
john

-- 
"It's a cardboard universe ... and if you lean too hard against it, you fall
 through." 
	- Philip K. Dick 
