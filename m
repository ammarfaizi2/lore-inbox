Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932254AbVH3SQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbVH3SQA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 14:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbVH3SQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 14:16:00 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:18443 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S932242AbVH3SP7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 14:15:59 -0400
Date: Tue, 30 Aug 2005 14:09:14 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>, discuss@x86-64.org,
       linux-ia64@vger.kernel.org, Asit.K.Mallick@intel.com,
       goutham.rao@intel.com, davidm@hpl.hp.com
Subject: Re: [patch 2.6.13] swiotlb: add swiotlb_sync_single_range_for_{cpu,device}
Message-ID: <20050830180912.GE18998@tuxdriver.com>
Mail-Followup-To: "Luck, Tony" <tony.luck@intel.com>,
	linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
	discuss@x86-64.org, linux-ia64@vger.kernel.org,
	Asit.K.Mallick@intel.com, goutham.rao@intel.com, davidm@hpl.hp.com
References: <B8E391BBE9FE384DAA4C5C003888BE6F0443A4B5@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F0443A4B5@scsmsx401.amr.corp.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2005 at 11:03:35AM -0700, Luck, Tony wrote:
> 
> >+swiotlb_sync_single_range_for_cpu(struct device *hwdev, 
> >+swiotlb_sync_single_range_for_device(struct device *hwdev, 
> 
> Huh?  These look identical ... same args, same code, just a
> different name.

Have you looked at the implementations for swiotlb_sync_single_for_cpu
and swiotlb_sync_single_for_device?  Those are already identical.

I'm just following the existing style/practice in that file.  I could
do an additional patch to rectify the replication in those functions
if you'd like?

Who is responsible for the swiotlb code?

John
-- 
John W. Linville
linville@tuxdriver.com
