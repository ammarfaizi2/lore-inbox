Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261373AbUJZRt6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbUJZRt6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 13:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbUJZRtG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 13:49:06 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:16817 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261359AbUJZRqf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 13:46:35 -0400
Date: Tue, 26 Oct 2004 10:45:55 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: Jesse Barnes <jbarnes@engr.sgi.com>, Robin Holt <holt@sgi.com>,
       Jesse Barnes <jbarnes@sgi.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Hugepages demand paging V2 [0/8]: Discussion and overview
In-Reply-To: <20041026174050.GK17038@holomorphy.com>
Message-ID: <Pine.LNX.4.58.0410261041170.19024@schroedinger.engr.sgi.com>
References: <B05667366EE6204181EABE9C1B1C0EB504BFA47C@scsmsx401.amr.corp.intel.com>
 <200410251940.30574.jbarnes@sgi.com> <20041026143513.GC28391@lnx-holt.americas.sgi.com>
 <200410260944.22003.jbarnes@engr.sgi.com> <20041026174050.GK17038@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Oct 2004, William Lee Irwin III wrote:

> And an architecture method for hugepage clearing.

Add clear_huge_page to asm-generic/pgtable.h and an associated
__HAVE_ARCH_CLEAR_HUGE_PAGE ?


