Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261362AbUJZRlR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbUJZRlR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 13:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbUJZRlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 13:41:17 -0400
Received: from holomorphy.com ([207.189.100.168]:486 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261362AbUJZRlA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 13:41:00 -0400
Date: Tue, 26 Oct 2004 10:40:50 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Robin Holt <holt@sgi.com>, Jesse Barnes <jbarnes@sgi.com>,
       Christoph Lameter <clameter@sgi.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Hugepages demand paging V2 [0/8]: Discussion and overview
Message-ID: <20041026174050.GK17038@holomorphy.com>
References: <B05667366EE6204181EABE9C1B1C0EB504BFA47C@scsmsx401.amr.corp.intel.com> <200410251940.30574.jbarnes@sgi.com> <20041026143513.GC28391@lnx-holt.americas.sgi.com> <200410260944.22003.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410260944.22003.jbarnes@engr.sgi.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, October 26, 2004 7:35 am, Robin Holt wrote:
>> One other feature of the BTE is it can operate asynchronously from
>> the cpu.  This could be used to, during a clock interrupt, schedule
>> additional huge page zero filling on multiple nodes at the same time.
>> This could result in a huge speed boost on machines that have multiple
>> memory only nodes.  That has not been tested thoroughly.  We have done
>> considerable testing of the page zero functionality as well as the
>> error handling.

On Tue, Oct 26, 2004 at 09:44:21AM -0700, Jesse Barnes wrote:
> Might be worth some additional testing...

And an architecture method for hugepage clearing.


-- wli
