Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318162AbSHNIOg>; Wed, 14 Aug 2002 04:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318192AbSHNIOg>; Wed, 14 Aug 2002 04:14:36 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:3849 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318162AbSHNIOf>; Wed, 14 Aug 2002 04:14:35 -0400
Date: Wed, 14 Aug 2002 09:18:26 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Greg Banks <gnb@alphalink.com.au>
Cc: Peter Samuelson <peter@cadcamlab.org>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: [patch] config language dep_* enhancements
Message-ID: <20020814091826.B2407@flint.arm.linux.org.uk>
References: <Pine.LNX.4.44.0208120924320.5882-100000@chaos.physics.uiowa.edu> <3D587483.1C459694@alphalink.com.au> <20020813033951.GF761@cadcamlab.org> <3D59110B.6D9A1223@alphalink.com.au> <20020813155330.GG761@cadcamlab.org> <3D59AEB7.7B80F33@alphalink.com.au> <20020814032841.GM761@cadcamlab.org> <3D59F22E.D0DA5FC6@alphalink.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D59F22E.D0DA5FC6@alphalink.com.au>; from gnb@alphalink.com.au on Wed, Aug 14, 2002 at 04:01:18PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2002 at 04:01:18PM +1000, Greg Banks wrote:
> > CONFIG_SERIAL and CONFIG_PCMCIA didn't generate any noise, though.
> 
> warning:drivers/parport/Config.in:14:forward declared symbol "CONFIG_SERIAL" compared ambiguously to "n"
> warning:drivers/parport/Config.in:14:forward reference to "CONFIG_SERIAL"
> warning:drivers/parport/Config.in:15:forward reference to "CONFIG_SERIAL"

I'm probably going to end up sucking the stuff that uses CONFIG_SERIAL in
parport into drivers/serial in the near future, which should solve this
problem.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

