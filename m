Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263342AbSLBBxC>; Sun, 1 Dec 2002 20:53:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263362AbSLBBxC>; Sun, 1 Dec 2002 20:53:02 -0500
Received: from surf.cadcamlab.org ([156.26.20.182]:34981 "EHLO
	surf.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S263342AbSLBBxB>; Sun, 1 Dec 2002 20:53:01 -0500
Date: Sun, 1 Dec 2002 19:56:36 -0600
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: i2c-amd766 driver for 2.5.50
Message-ID: <20021202015636.GC4182@cadcamlab.org>
References: <20021201233451.GB4182@cadcamlab.org> <20021202005502.GA30652@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021202005502.GA30652@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.4i
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Pavel Machek]
> > MOD_LIST_NAME was deprecated in 2.3.  'include Rules.make' was
> > deprecated in 2.5.  Also appears in drivers/i2c/chips/Makefile.
> 
> I agree with MOD_LIST_NAME, but I still see include
> $(TOPDIR)/Rules.make used all over the kernel, so I kept it.

It's dead.  The 500-odd Makefiles haven't all been changed yet.
If you don't believe me, check out the contents of Rules.make. (:

Peter
