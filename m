Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267656AbUHENi4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267656AbUHENi4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 09:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267218AbUHENhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 09:37:47 -0400
Received: from holomorphy.com ([207.189.100.168]:21443 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267687AbUHENgk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 09:36:40 -0400
Date: Thu, 5 Aug 2004 06:36:37 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       "Seth, Rohit" <rohit.seth@intel.com>
Subject: Re: Hugetlb demanding paging for -mm tree
Message-ID: <20040805133637.GG14358@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
	"Seth, Rohit" <rohit.seth@intel.com>
References: <200408051329.i75DT3Y26431@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408051329.i75DT3Y26431@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2004 at 06:29:02AM -0700, Chen, Kenneth W wrote:
> Dusted it off from 3 month ago.  This time re-diffed against 2.6.8-rc3-mm1.
> One big change compare to previous release is this patch should work for
> ALL arch that supports hugetlb page.  I have tested it on ia64 and x86.
> For x86, tested with no highmem config, 4G highmem config and PAE config.
> I have not tested it on sh, sparc64 and ppc64, but I have no reason to
> believe that this feature won't work on these arches.
> Patches are broken into two pieces.  But they should be applied together
> to have correct functionality for hugetlb demand paging.
> 00.demandpaging.patch - core hugetlb demand paging
> 01.overcommit.patch   - hugetlbfs strict overcommit accounting.
> Testing and comments are welcome.  Thanks.
> - Ken Chen

Could you resend as plaintext?


-- wli
