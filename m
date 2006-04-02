Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751651AbWDBCwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751651AbWDBCwI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 21:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751654AbWDBCwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 21:52:08 -0500
Received: from mtaout2.012.net.il ([84.95.2.4]:15252 "EHLO mtaout2.012.net.il")
	by vger.kernel.org with ESMTP id S1751651AbWDBCwH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 21:52:07 -0500
Date: Sun, 02 Apr 2006 05:51:24 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
Subject: Re: [patch 2.6.16-git] dma doc updates
In-reply-to: <200604011021.53162.david-b@pacbell.net>
To: David Brownell <david-b@pacbell.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
Message-id: <20060402025124.GI25945@granada.merseine.nu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <200604011021.53162.david-b@pacbell.net>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 01, 2006 at 10:21:52AM -0800, David Brownell wrote:

> +	int
> +	dma_map_sg(struct device *dev, struct scatterlist *sg,
> +		int nents, enum dma_data_direction direction)

While you're at it, care to s/enum dma_data_direction/int/? some archs
use one and some use the other, and there was weak consensus that int
is better.

Cheers,
Muli
-- 
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

