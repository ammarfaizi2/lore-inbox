Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318975AbSHNIMZ>; Wed, 14 Aug 2002 04:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319241AbSHNIMZ>; Wed, 14 Aug 2002 04:12:25 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:64776 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318975AbSHNIMZ>; Wed, 14 Aug 2002 04:12:25 -0400
Date: Wed, 14 Aug 2002 09:16:12 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Peter Samuelson <peter@cadcamlab.org>
Cc: Greg Banks <gnb@alphalink.com.au>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [patch] kernel config 3/N - move sound into drivers/media
Message-ID: <20020814091612.A2407@flint.arm.linux.org.uk>
References: <Pine.LNX.4.44.0208120924320.5882-100000@chaos.physics.uiowa.edu> <3D587483.1C459694@alphalink.com.au> <20020813033951.GF761@cadcamlab.org> <3D59110B.6D9A1223@alphalink.com.au> <20020813155330.GG761@cadcamlab.org> <3D59AEB7.7B80F33@alphalink.com.au> <20020814032841.GM761@cadcamlab.org> <20020814043558.GN761@cadcamlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020814043558.GN761@cadcamlab.org>; from peter@cadcamlab.org on Tue, Aug 13, 2002 at 11:35:58PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2002 at 11:35:58PM -0500, Peter Samuelson wrote:
> The big loser here is ARM - it no longer suppresses the sound card
> question for the appropriate boards.  But it's just one question, so I
> didn't sweat it too much.

I'd be tempted to drop that set of tests, and just rely on the per-driver
stuff, where its sane to do so.  There's no way we can special case all
the drivers out there for each machine type in the generic config files.
That is the route to madness.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

