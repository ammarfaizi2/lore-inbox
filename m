Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261363AbUJZRsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbUJZRsL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 13:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbUJZRsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 13:48:11 -0400
Received: from holomorphy.com ([207.189.100.168]:5862 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261363AbUJZRrs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 13:47:48 -0400
Date: Tue, 26 Oct 2004 10:47:37 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, Robin Holt <holt@sgi.com>,
       Jesse Barnes <jbarnes@sgi.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Hugepages demand paging V2 [0/8]: Discussion and overview
Message-ID: <20041026174737.GM17038@holomorphy.com>
References: <B05667366EE6204181EABE9C1B1C0EB504BFA47C@scsmsx401.amr.corp.intel.com> <200410251940.30574.jbarnes@sgi.com> <20041026143513.GC28391@lnx-holt.americas.sgi.com> <200410260944.22003.jbarnes@engr.sgi.com> <20041026174050.GK17038@holomorphy.com> <Pine.LNX.4.58.0410261041170.19024@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410261041170.19024@schroedinger.engr.sgi.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Oct 2004, William Lee Irwin III wrote:
>> And an architecture method for hugepage clearing.

On Tue, Oct 26, 2004 at 10:45:55AM -0700, Christoph Lameter wrote:
> Add clear_huge_page to asm-generic/pgtable.h and an associated
> __HAVE_ARCH_CLEAR_HUGE_PAGE ?

Or a weak function.


-- wli
