Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267737AbUJVUvK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267737AbUJVUvK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 16:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267807AbUJVUul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 16:50:41 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:35562 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267759AbUJVUtd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 16:49:33 -0400
Date: Fri, 22 Oct 2004 13:49:24 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, raybry@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: Hugepages demand paging V1 [2/4]: set_huge_pte() arch updates
In-Reply-To: <20041022204506.GD17038@holomorphy.com>
Message-ID: <Pine.LNX.4.58.0410221349050.10087@schroedinger.engr.sgi.com>
References: <B05667366EE6204181EABE9C1B1C0EB501F2ADFB@scsmsx401.amr.corp.intel.com>
 <Pine.LNX.4.58.0410212151310.3524@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0410212156300.3524@schroedinger.engr.sgi.com>
 <20041022103708.GK17038@holomorphy.com> <Pine.LNX.4.58.0410220829200.7868@schroedinger.engr.sgi.com>
 <20041022154219.GY17038@holomorphy.com> <Pine.LNX.4.58.0410221318370.9833@schroedinger.engr.sgi.com>
 <20041022204506.GD17038@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Oct 2004, William Lee Irwin III wrote:

> It's not done at all for hugepages now, and needs to be. Fault handling
> on hugetlb vmas will likely expose the cahing of stale data more readily.

Hmm... Looks like there is a long way ahead of us.

