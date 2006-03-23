Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932435AbWCWJjg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbWCWJjg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 04:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932507AbWCWJjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 04:39:36 -0500
Received: from [194.90.237.34] ([194.90.237.34]:17040 "EHLO mtlexch01.mtl.com")
	by vger.kernel.org with ESMTP id S932435AbWCWJjf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 04:39:35 -0500
Date: Thu, 23 Mar 2006 11:40:26 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: linux-kernel@vger.kernel.org, rdreier@cisco.com, greg@kroah.com,
       openib-general@openib.org
Subject: Re: [PATCH 8 of 18] ipath - sysfs and ipathfs support for core driver
Message-ID: <20060323094026.GC1802@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <patchbomb.1143072293@eng-12.pathscale.com> <03375633b9c13068de17.1143072301@eng-12.pathscale.com> <20060323063049.GB9841@mellanox.co.il> <1143103569.6411.18.camel@camp4.serpentine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143103569.6411.18.camel@camp4.serpentine.com>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 23 Mar 2006 09:42:19.0468 (UTC) FILETIME=[13EAB8C0:01C64E5E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Bryan O'Sullivan <bos@pathscale.com>:
> > InfiniBand core already exposes these attributes to userspace, see
> > drivers/infiniband/core/sysfs.c
> 
> This is needed for cases where the Infiniband stack isn't present.

But re-implementing same thing with a different kernel-user interface and
pushing it into a low-level driver does not strike me like a sane solution.

-- 
Michael S. Tsirkin
Staff Engineer, Mellanox Technologies
