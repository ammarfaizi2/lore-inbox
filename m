Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261638AbUKGVKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbUKGVKE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 16:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbUKGVKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 16:10:04 -0500
Received: from holomorphy.com ([207.189.100.168]:38287 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261638AbUKGVJz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 16:09:55 -0500
Date: Sun, 7 Nov 2004 13:09:43 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Anton Blanchard <anton@samba.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, linux-kernel@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, Adam Litke <agl@us.ibm.com>,
       Andy Whitworth <apw@shadowen.org>
Subject: Re: [RFC] Consolidate lots of hugepage code
Message-ID: <20041107210943.GN2890@holomorphy.com>
References: <20041029033708.GF12247@zax> <20041029034817.GY12934@holomorphy.com> <20041107172030.GA16976@krispykreme.ozlabs.ibm.com> <20041107192024.GM2890@holomorphy.com> <20041107193007.GC16976@krispykreme.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041107193007.GC16976@krispykreme.ozlabs.ibm.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> The second is a triplefault on x86-64 under some
>> condition involving a long-running database regression test. There has
>> obviously been considerably less progress there in no small part due to
>> the amount of time required to reproduce the issue.

On Mon, Nov 08, 2004 at 06:30:07AM +1100, Anton Blanchard wrote:
> OK. We have not seen a similar issue on ppc64 even with extensive
> testing (although with HPC apps). The question is how long we should
> hold off on further hugetlb development waiting for this one bug report
> on a single architecture to be chased.

Until it's fixed. Until then I'm considering it a byproduct of that same
development. And with your report, that makes it two architectures, not
one.

The concepts of the features etc. are all generally okay, though very
buzzword-centric. In general the audits and sweeps have been lacking
thoroughness in the architecture-specific areas. I expect that
particular issue to have been the cause of these two bugreports.


-- wli
