Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934223AbWK2Fvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934223AbWK2Fvn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 00:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934202AbWK2Fvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 00:51:43 -0500
Received: from excu-mxob-2.symantec.com ([198.6.49.23]:17383 "EHLO
	excu-mxob-2.symantec.com") by vger.kernel.org with ESMTP
	id S934180AbWK2Fvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 00:51:42 -0500
X-AuditID: c6063117-a2490bb000005266-63-456d1e98c76c 
Date: Wed, 29 Nov 2006 05:46:17 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Mingming Cao <cmm@us.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, Mel Gorman <mel@skynet.ie>,
       "Martin J. Bligh" <mbligh@mbligh.org>, linux-kernel@vger.kernel.org,
       "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 1/12] ext3 balloc: reset windowsz when full
In-Reply-To: <1164773634.4341.34.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0611290530250.32007@blonde.wat.veritas.com>
References: <1164773634.4341.34.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 29 Nov 2006 05:46:00.0516 (UTC) FILETIME=[A6499840:01C71379]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2006, Mingming Cao wrote:

> Port a series ext2 balloc patches from Hugh to ext3/4. The first 6
> patches are against ext3, and the rest are aginst ext4.

Thanks for all that, Mingming:
whichever is appropriate, all twelve
Acked-by: Hugh Dickins <hugh@veritas.com>
or
Signed-off-by: Hugh Dickins <hugh@veritas.com>

I'll think about your other mails, those that need further thought,
later on: I need to pin down more accurately the repetitious sequence of
reservations in the mistaken case - maybe it indicated further issues,
maybe not; and I need to consider our different views of the my_rsv
find_next_usable_block.

Hugh
