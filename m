Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270976AbTGPRD3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 13:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270974AbTGPRDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 13:03:25 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:60350 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S270976AbTGPRCR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 13:02:17 -0400
Date: Wed, 16 Jul 2003 19:17:06 +0200
From: Jens Axboe <axboe@suse.de>
To: Valdis.Kletnieks@vt.edu
Cc: Dave Jones <davej@codemonkey.org.uk>, vojtech@suse.cz,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PS2 mouse going nuts during cdparanoia session.
Message-ID: <20030716171706.GN833@suse.de>
References: <20030716165701.GA21896@suse.de> <20030716170352.GJ833@suse.de> <200307161710.h6GHAsU1001493@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307161710.h6GHAsU1001493@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16 2003, Valdis.Kletnieks@vt.edu wrote:
> On Wed, 16 Jul 2003 19:03:52 +0200, Jens Axboe <axboe@suse.de>  said:
> 
> > Yes. You can try and make the situation a little better by unmasking
> > interrupts with -u1. Or you can try and use a ripper that actually uses
> > SG_IO, that way you can use dma (and zero copy) for the rips. That will
> > be lots more smooth.
> 
> Dumb user question - which rippers support SG_IO?  I've been using
> cdparanoia mostly for lack of a good reason to migrate - but this
> sounds like a good reason. ;)

Not a dumb question at all, see my previous mail :). In short, I don't
know. I'm sure a little collective effort could hunt some down (cdda2wav
should work, since it uses libscg presumable).

-- 
Jens Axboe

