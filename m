Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750880AbWBZUj0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbWBZUj0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 15:39:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750931AbWBZUj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 15:39:26 -0500
Received: from colin.muc.de ([193.149.48.1]:62475 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1750880AbWBZUjZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 15:39:25 -0500
Date: 26 Feb 2006 21:39:17 +0100
Date: Sun, 26 Feb 2006 21:39:17 +0100
From: Andi Kleen <ak@muc.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Chuck Ebbert <76306.1226@compuserve.com>, linux-kernel@vger.kernel.org,
       largret@gmail.com, axboe@suse.de
Subject: Re: OOM-killer too aggressive?
Message-ID: <20060226203917.GA76858@muc.de>
References: <200602260938_MC3-1-B94B-EE2B@compuserve.com> <20060226102152.69728696.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060226102152.69728696.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2006 at 10:21:52AM -0800, Andrew Morton wrote:
> Chuck Ebbert <76306.1226@compuserve.com> wrote:
> >
> > Chris Largret is getting repeated OOM kills because of DMA memory
> > exhaustion:
> > 
> > oom-killer: gfp_mask=0xd1, order=3
> > 
> 
> This could be related to the known GFP_DMA oom on some x86_64 machines.

What known GFP_DMA oom? GFP_DMA allocation should work.

-Andi
