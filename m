Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290382AbSAPHOU>; Wed, 16 Jan 2002 02:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289757AbSAPHOJ>; Wed, 16 Jan 2002 02:14:09 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:23817 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S290381AbSAPHNu>; Wed, 16 Jan 2002 02:13:50 -0500
Date: Wed, 16 Jan 2002 01:13:46 -0600
To: "Eric S. Raymond" <esr@thyrsus.com>, Rob Landley <landley@trommello.org>,
        Nicolas Pitre <nico@cam.org>, lkml <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: CML2-2.1.3 is available
Message-ID: <20020116071346.GD2067@cadcamlab.org>
In-Reply-To: <Pine.LNX.4.33.0201151538340.5892-100000@xanadu.home> <20020116034137.CRFB26021.femail12.sdc1.sfba.home.com@there> <20020115224821.A4658@thyrsus.com> <20020116062942.GC2067@cadcamlab.org> <20020116013250.A3880@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020116013250.A3880@thyrsus.com>
User-Agent: Mutt/1.3.25i
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Forgot this point earlier..

[esr]
> > > The version I just released does exactly that.  Well, not exactly; it
> > > actually looks at fstab -- /proc/mounts gives you '/dev/root' rather
> > > than a physical device name in the root entry.

IMHO you should still use /proc/mounts to determine the root filesystem
type.  In my fstab file I don't mention ext3 anywhere - I use 'auto' as
fs type instead.  That way my ext3 partitions will mount correctly when
I boot a non-ext3-capable kernel.  (They mount as ext2 in that case.)

Peter
