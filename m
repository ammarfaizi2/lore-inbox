Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932512AbWGSGPr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932512AbWGSGPr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 02:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932513AbWGSGPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 02:15:47 -0400
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:17744 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP id S932512AbWGSGPq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 02:15:46 -0400
Date: Wed, 19 Jul 2006 09:15:42 +0300
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Panagiotis Issaris <takis@lumumba.uhasselt.be>
Cc: linux-kernel@vger.kernel.org, kyle@parisc-linux.org,
       twoller@crystal.cirrus.com, James@superbug.demon.co.uk, zab@zabbo.net,
       sailer@ife.ee.ethz.ch, perex@suse.cz, zaitcev@yahoo.com
Subject: Re: [PATCH] sound: Conversions from kmalloc+memset to k(z|c)alloc.
Message-ID: <20060719061542.GG5764@rhun.ibm.com>
References: <20060719005455.GB30823@lumumba.uhasselt.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060719005455.GB30823@lumumba.uhasselt.be>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2006 at 02:54:55AM +0200, Panagiotis Issaris wrote:

> From: Panagiotis Issaris <takis@issaris.org>
> 
> sound: Conversions from kmalloc+memset to k(c|z)alloc.
> 
> Signed-off-by: Panagiotis Issaris <takis@issaris.org>

> diff --git a/sound/oss/trident.c b/sound/oss/trident.c
> index 2813e4c..e81ee7a 100644
> --- a/sound/oss/trident.c
> +++ b/sound/oss/trident.c

trident.c changes are ok and

Acked-by: Muli Ben-Yehuda <muli@il.ibm.com>

Cheers,
Muli
