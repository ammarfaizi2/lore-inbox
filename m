Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319279AbSHNV7b>; Wed, 14 Aug 2002 17:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319340AbSHNV7b>; Wed, 14 Aug 2002 17:59:31 -0400
Received: from crack.them.org ([65.125.64.184]:57098 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S319279AbSHNV7b>;
	Wed, 14 Aug 2002 17:59:31 -0400
Date: Wed, 14 Aug 2002 18:03:17 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Rogier Wolff <R.E.Wolff@BitWizard.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 4/21] fix ARCH_HAS_PREFETCH
Message-ID: <20020814220317.GA22207@nevyn.them.org>
Mail-Followup-To: Jamie Lokier <lk@tantalophile.demon.co.uk>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Rogier Wolff <R.E.Wolff@BitWizard.nl>, linux-kernel@vger.kernel.org
References: <3D56B13A.D3F741D1@zip.com.au> <Pine.NEB.4.44.0208132322340.1351-100000@mimas.fachschaften.tu-muenchen.de> <ajc095$hk1$1@cesium.transmeta.com> <20020814194019.A31761@bitwizard.nl> <3D5AB250.3070104@zytor.com> <20020814205709.E26404@kushida.apsleyroad.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020814205709.E26404@kushida.apsleyroad.org>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2002 at 08:57:09PM +0100, Jamie Lokier wrote:
> H. Peter Anvin wrote:
> > Yes.  This is a gcc-specific wart, a bad idea from the start, and 
> > apparently one which has caught up with them to the point that they've 
> > had to abandon it.
> 
> It's still there in GCC 3.1.

Yes.  If you check out the tree-ssa-branch, however (and use
appropriate commandline arguments), I think you'll find that it's no
longer there.  That's the future of GCC's optimizer, but most of it
won't make even GCC 3.3.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
