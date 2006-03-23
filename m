Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932332AbWCWGkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbWCWGkX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 01:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbWCWGkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 01:40:23 -0500
Received: from [194.90.237.34] ([194.90.237.34]:37927 "EHLO mtlexch01.mtl.com")
	by vger.kernel.org with ESMTP id S932332AbWCWGkX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 01:40:23 -0500
Date: Thu, 23 Mar 2006 08:41:13 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: linux-kernel@vger.kernel.org, rdreier@cisco.com, greg@kroah.com,
       openib-general@openib.org
Subject: Re: [PATCH 9 of 18] ipath - char devices for diagnostics and lightweight subnet management
Message-ID: <20060323064113.GC9841@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <patchbomb.1143072293@eng-12.pathscale.com> <dffa0687112e4fdcf7d0.1143072302@eng-12.pathscale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dffa0687112e4fdcf7d0.1143072302@eng-12.pathscale.com>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 23 Mar 2006 06:43:06.0593 (UTC) FILETIME=[0AB43510:01C64E45]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Bryan O'Sullivan <bos@pathscale.com>:
> The ipath_sma.c file supports a lightweight userspace subnet management
> agent (SMA).  This is used in deployments (such as HPC clusters) where
> a full Infiniband protocol stack is not needed.

Could you please explain why is this useful? Users could not care less - they
never have to touch an SMA. The "full" Infiniband stack is very lightweight and
already includes an SMA, and it already includes ib_umad module which makes it
possible to implement subnet management in userspace should you want to.

-- 
Michael S. Tsirkin
Staff Engineer, Mellanox Technologies
