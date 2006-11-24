Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934510AbWKXXHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934510AbWKXXHX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 18:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932502AbWKXXHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 18:07:23 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:56744 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S934510AbWKXXHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 18:07:22 -0500
To: Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>
Cc: Christoph Raisch <raisch@de.ibm.com>,
       Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       linuxppc-dev-bounces+hnguyen=de.ibm.com@ozlabs.org,
       openib-general@openib.org
Subject: Re: [PATCH 2.6.19] ehca: bug fix: use wqe offset instead wqe address	to determine pending work requests
X-Message-Flag: Warning: May contain useful information
References: <OFCFF36ACF.6FF07D9E-ONC125722F.00499C9C-C125722F.0049F685@de.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 24 Nov 2006 15:07:20 -0800
Message-ID: <adafyc88mvr.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 24 Nov 2006 23:07:20.0727 (UTC) FILETIME=[4B547270:01C7101D]
Authentication-Results: sj-dkim-4; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim4002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > That's fair. I understand your decision. And thanks for queueing for
 > 2.6.20. Can you please brief me on patch procedures for post-2.6.19?

What do you mean by post-2.6.19?  Things go into 2.6.19.x via
stable@kernel.org, if that's what you're asking.

Documentation/stable_kernel_rules.txt describes what patches are
appropriate for 2.6.19.x, and given that we're so close to the 2.6.19
final release, I'm working under similar rules for what I'm going to
merge into 2.6.19.
