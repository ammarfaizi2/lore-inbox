Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264651AbTE1LAm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 07:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264652AbTE1LAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 07:00:42 -0400
Received: from holomorphy.com ([66.224.33.161]:39296 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264651AbTE1LAk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 07:00:40 -0400
Date: Wed, 28 May 2003 04:13:45 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.67-mm1 bootcrash, possibly IDE or RAID
Message-ID: <20030528111345.GU8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Helge Hafting <helgehaf@aitel.hist.no>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20030408042239.053e1d23.akpm@digeo.com> <3ED49A14.2020704@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ED49A14.2020704@aitel.hist.no>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 28, 2003 at 01:14:28PM +0200, Helge Hafting wrote:
> 2.5.69-mm8 is fine, 2.5.67-mm1 dies before mounting anything read-write.
> The early kernel boot is fine, the penguin appear,
> a bunch of the usual messages scroll by too fast to read,
> and then it hangs.
> The kernel is UP, with preempt & devfs.  All filesystems
> are ext2. This kernel has no module support.
> Root is on raid-1, there are two
> ide disks connected to this controller on separate cables:
> 00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE]

Well, bugs were fixed since 2.5.67-mm1. Just upgrade to the most recent
kernel (2.5.70-mm1).


-- wli
