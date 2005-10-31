Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932487AbVJaTEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbVJaTEl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 14:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbVJaTEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 14:04:41 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:41538 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932487AbVJaTEk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 14:04:40 -0500
Date: Mon, 31 Oct 2005 20:05:38 +0100
From: Jens Axboe <axboe@suse.de>
To: Michal Vanco <michal.vanco@satro.sk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: HDD LED on 82801FBM
Message-ID: <20051031190537.GB19267@suse.de>
References: <200510311944.45295.michal.vanco@satro.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510311944.45295.michal.vanco@satro.sk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31 2005, Michal Vanco wrote:
> Hi all,
> 
> HDD LED on my Laptop (Fujitsu-Siemens LB E8020) never goes off when
> 2.6 kernel is running (tested with 2.6.10-2.6.13.4). 

It's a bug in the ahci driver, which coincidentally is fixed with
2.6.14. So you should upgrade :)

-- 
Jens Axboe

