Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262256AbUJ0GxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262256AbUJ0GxR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 02:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262289AbUJ0Guy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 02:50:54 -0400
Received: from holomorphy.com ([207.189.100.168]:35820 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262256AbUJ0GtE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 02:49:04 -0400
Date: Tue, 26 Oct 2004 23:48:51 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Hugepages demand paging V2 [0/8]: Discussion and overview
Message-ID: <20041027064851.GW15367@holomorphy.com>
References: <B05667366EE6204181EABE9C1B1C0EB504BFA47C@scsmsx401.amr.corp.intel.com> <Pine.LNX.4.58.0410251825020.12962@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410251825020.12962@schroedinger.engr.sgi.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 06:26:42PM -0700, Christoph Lameter wrote:
> Hugetlb demand paging has been part of SuSE SLES 9 for awhile now and
> this patchset is intended to help hugetlb demand paging also get into
> the official Linux kernel. Huge pages are referred to as "compound"
> pages in terms of "struct page" in the Linux kernel. The term
"compund page" may be used alternatively to huge page.

This may very well explain why SLES9 is triplefaulting when Oracle
tries to use hugetlb on it on x86-64.

Since all this is clearly malfunctioning and not done anywhere near
carefully enough, can I at least get *some* sanction to do any of this
differently?


-- wli
