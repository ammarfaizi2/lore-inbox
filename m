Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932462AbWGSDGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbWGSDGH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 23:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932466AbWGSDGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 23:06:07 -0400
Received: from ra.tuxdriver.com ([70.61.120.52]:63503 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S932462AbWGSDGF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 23:06:05 -0400
Date: Tue, 18 Jul 2006 22:48:05 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Panagiotis Issaris <takis@lumumba.uhasselt.be>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, nico@cam.org,
       patrick@tykepenguin.com, davem@davemloft.net
Subject: Re: [PATCH] Conversions from kmalloc+memset to k(z|c)alloc.
Message-ID: <20060719024805.GB3786@tuxdriver.com>
Mail-Followup-To: Panagiotis Issaris <takis@lumumba.uhasselt.be>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, nico@cam.org,
	patrick@tykepenguin.com, davem@davemloft.net
References: <20060719011540.GD30823@lumumba.uhasselt.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060719011540.GD30823@lumumba.uhasselt.be>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2006 at 03:15:40AM +0200, Panagiotis Issaris wrote:
> From: Panagiotis Issaris <takis@issaris.org>
> 
> Conversions from kmalloc+memset to k(z|c)alloc.  The original memsets
> did not clear out the entire allocated structure. To my unexperienced
> eye, that seemed a bit fishy (or at least a bit weird and inconsistent).
> 
> Signed-off-by: Panagiotis Issaris <takis@issaris.org>

Signed-off-by: John W. Linville <linville@tuxdriver.com>

-- 
John W. Linville
linville@tuxdriver.com
