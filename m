Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267919AbTBYK5I>; Tue, 25 Feb 2003 05:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267920AbTBYK5H>; Tue, 25 Feb 2003 05:57:07 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:61478 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S267919AbTBYK5H>; Tue, 25 Feb 2003 05:57:07 -0500
Date: Tue, 25 Feb 2003 13:07:04 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Mikael Starvik <mikael.starvik@axis.com>,
       "'Randy.Dunlap'" <rddunlap@osdl.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'tinglett@vnet.ibm.com'" <tinglett@vnet.ibm.com>,
       "'torvalds@transmeta.com'" <torvalds@transmeta.com>
Subject: Re: zImage now holds vmlinux, System.map and config in sections. (fwd)
Message-ID: <20030225110704.GD159052@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Mikael Starvik <mikael.starvik@axis.com>,
	"'Randy.Dunlap'" <rddunlap@osdl.org>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	"'tinglett@vnet.ibm.com'" <tinglett@vnet.ibm.com>,
	"'torvalds@transmeta.com'" <torvalds@transmeta.com>
References: <3C6BEE8B5E1BAC42905A93F13004E8AB017DE84C@mailse01.axis.se> <20030225092520.A9257@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030225092520.A9257@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2003 at 09:25:20AM +0000, you [Russell King] wrote:
> On Tue, Feb 25, 2003 at 07:28:46AM +0100, Mikael Starvik wrote:
> > >I don't know linker scripts very well.
> > >Can this be done for all architectures?
> > >I'd like to see a solution that is arch-independent.
> > 
> > In embedded systems it is probably not desirable to keep 
> > System.map and config in zImage (takes too much valuable space).
> 
> Agreed - zImage is already around 1MB on many ARM machines, and since
> loading zImage over a serial port using xmodem takes long enough
> already, this is one silly feature I'll definitely keep out of the
> ARM tree.

Why not make it a config option (like the other (two? three?) rejected
patches that implemented this did)?


-- v --

v@iki.fi
