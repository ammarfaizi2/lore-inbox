Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265093AbUELNhs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265093AbUELNhs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 09:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265026AbUELNhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 09:37:24 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:29396 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S265048AbUELNfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 09:35:17 -0400
Date: Wed, 12 May 2004 06:32:36 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Valdis.Kletnieks@vt.edu
Cc: akpm@osdl.org, benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PPC32: New OCP core support
Message-ID: <20040512063236.C8797@home.com>
References: <20040511170150.A4743@home.com> <200405120039.i4C0dHs0010426@turing-police.cc.vt.edu> <20040511180144.A4901@home.com> <000001c437cd$52469fc0$d100000a@sbs2003.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <000001c437cd$52469fc0$d100000a@sbs2003.local>; from Valdis.Kletnieks@vt.edu on Wed, May 12, 2004 at 04:00:46AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2004 at 04:00:46AM +0100, Valdis.Kletnieks@vt.edu wrote:
> 
> On Tue, 11 May 2004 18:01:44 PDT, Matt Porter said:
> 
> > Actually, OCP stands for On-Chip Peripheral and is the basic system
> > we've used in ppc32 for some time now to abstract dumb peripherals
> > behind a standard API. BenH did yet another rewrite of OCP in 2.4
> > sometime ago and I picked up that work to port to 2.6 and the new
> > device model. It is a software abstraction, and easily allows us to
> > plug in SoC descriptors when new chips come out and use standard apis
> > to modify device entries on a per-board basis during "setup_arch()
> > time". It used to be PPC4xx-specific, but now is being used by
> > PPC85xx, MV64xxx, and MPC52xx based PPC systems. "Now", meaning that
> > the respective developers for those parts are using the OCP working
> > tree to base their 2.6 ports off of.
> 
> Wrap a /* */ around that paragraph and add it to the top of ppc/syslib/ocp.c :)

I incorporated a more polished version into the updated patch I just
sent.

Thanks.

-Matt
