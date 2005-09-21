Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751172AbVIUS6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbVIUS6T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 14:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbVIUS6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 14:58:19 -0400
Received: from gold.veritas.com ([143.127.12.110]:20788 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751172AbVIUS6S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 14:58:18 -0400
Date: Wed, 21 Sep 2005 19:57:53 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Frank van Maarseveen <frankvm@frankvm.com>
cc: Christoph Lameter <clameter@engr.sgi.com>, linux-kernel@vger.kernel.org,
       Jay Lan <jlan@engr.sgi.com>
Subject: Re: [PATCH 2.6.14-rc2] fix incorrect mm->hiwater_vm and mm->hiwater_rss
In-Reply-To: <20050921184211.GC17272@janus>
Message-ID: <Pine.LNX.4.61.0509211955170.10449@goblin.wat.veritas.com>
References: <20050921121915.GA14645@janus> <Pine.LNX.4.61.0509211515330.6114@goblin.wat.veritas.com>
 <20050921145833.GA15682@janus> <Pine.LNX.4.61.0509211621410.7001@goblin.wat.veritas.com>
 <20050921184211.GC17272@janus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 21 Sep 2005 18:58:17.0946 (UTC) FILETIME=[6D8643A0:01C5BEDE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Sep 2005, Frank van Maarseveen wrote:
> 
> Most software we develop at my work uses this to test for regression
> in memory usage. Just before program exit it reads /proc/pid/status:VmPeak
> and reports it. Scripts do the rest.

That makes some sense.  Thank you for explaining it.

Hugh
