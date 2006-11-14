Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966360AbWKNVRs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966360AbWKNVRs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 16:17:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966362AbWKNVRs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 16:17:48 -0500
Received: from extu-mxob-2.symantec.com ([216.10.194.135]:51407 "EHLO
	extu-mxob-2.symantec.com") by vger.kernel.org with ESMTP
	id S966360AbWKNVRr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 16:17:47 -0500
X-AuditID: d80ac287-9f493bb000002ee7-0e-455a327a8ae0 
Date: Tue, 14 Nov 2006 21:18:05 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Mel Gorman <mel@skynet.ie>, "Martin J. Bligh" <mbligh@mbligh.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Boot failure with ext2 and initrds
In-Reply-To: <20061114113120.d4c22b02.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0611142111380.19259@blonde.wat.veritas.com>
References: <20061114014125.dd315fff.akpm@osdl.org> <20061114184919.GA16020@skynet.ie>
 <Pine.LNX.4.64.0611141858210.11956@blonde.wat.veritas.com>
 <20061114113120.d4c22b02.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 14 Nov 2006 21:17:46.0376 (UTC) FILETIME=[54949880:01C70832]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2006, Andrew Morton wrote:
> 
> The below might help.

Indeed it does (with Martin's E2FSBLK warning fix),
seems to be running well on all machines now.

(Of course, my ext2_fsblk_t ext2_new_blocks() notion did not pan out,
for same reason as the original: that ret_block was expected signed.)

Thanks,
Hugh
