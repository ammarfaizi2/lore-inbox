Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267935AbTBYLx4>; Tue, 25 Feb 2003 06:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267937AbTBYLx4>; Tue, 25 Feb 2003 06:53:56 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:63022 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S267935AbTBYLxz>; Tue, 25 Feb 2003 06:53:55 -0500
Date: Tue, 25 Feb 2003 14:03:57 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Mikael Starvik <mikael.starvik@axis.com>,
       "'Randy.Dunlap'" <rddunlap@osdl.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'tinglett@vnet.ibm.com'" <tinglett@vnet.ibm.com>,
       "'torvalds@transmeta.com'" <torvalds@transmeta.com>
Subject: Re: zImage now holds vmlinux, System.map and config in sections. (fwd)
Message-ID: <20030225120357.GC158866@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Mikael Starvik <mikael.starvik@axis.com>,
	"'Randy.Dunlap'" <rddunlap@osdl.org>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	"'tinglett@vnet.ibm.com'" <tinglett@vnet.ibm.com>,
	"'torvalds@transmeta.com'" <torvalds@transmeta.com>
References: <3C6BEE8B5E1BAC42905A93F13004E8AB017DE84C@mailse01.axis.se> <20030225092520.A9257@flint.arm.linux.org.uk> <20030225110704.GD159052@niksula.cs.hut.fi> <20030225113557.C9257@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030225113557.C9257@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[This has been beaten to death multiple times over the years - I'm sorry to
repeat the same remarks again...]

On Tue, Feb 25, 2003 at 11:35:57AM +0000, you [Russell King] wrote:
> 
> I, for one, do not see any point in trying to put more and more crap
> into one file, when its perfectly easy to just use the "cp" command
> 
> <snip instructions>

I do appreciate that you find no use for this feature. You instructions will
work fine if one always compiles the kernel using the same discipline and
and stores them under /boot on the same computer.

Not everybody are always that careful. I know I'm not. I've copied tens of
kernels to floppy ("cp bzImage /dev/fd0" because it's so easy to do), and
lost track which one is which. I've copied kernels to other computers, and
lost track which is which. I've made mistakes copying kernels to /boot, and
lost track which is which.

I have been using Peter Breuer's proconfig patch and I have found it useful.
Just cat /proc/config, and there you have the config for the running kernel
- no matter if it was booted from a throw-away floppy, network or /boot.
It only adds couple of kB to the bzImage, and I am ready to pay that price.

If you are not - well it is a config option for that very reason. 


-- v --

v@iki.fi
