Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290767AbSCOLKD>; Fri, 15 Mar 2002 06:10:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290120AbSCOLIh>; Fri, 15 Mar 2002 06:08:37 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:42000 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S290587AbSCOLGj>;
	Fri, 15 Mar 2002 06:06:39 -0500
Date: Fri, 15 Mar 2002 12:06:27 +0100
From: Jens Axboe <axboe@suse.de>
To: Jari Ruusu <jari.ruusu@pp.inet.fi>
Cc: Andrea Arcangeli <andrea@suse.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Herbert Valerio Riedel <hvr@hvrlab.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre3aa2
Message-ID: <20020315110627.GE22169@suse.de>
In-Reply-To: <20020314032801.C1273@dualathlon.random> <3C912ACF.AF3EE6F0@pp.inet.fi> <20020315105621.GA22169@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020315105621.GA22169@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15 2002, Jens Axboe wrote:
> On Fri, Mar 15 2002, Jari Ruusu wrote:
> > - No more illegal sleeping in generic_make_request().

BTW, it looks like you are killing LO_FLAGS_BH_REMAP?! Why? This is a
very worthwhile optimization.

-- 
Jens Axboe

