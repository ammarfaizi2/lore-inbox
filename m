Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751973AbWI1SPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751973AbWI1SPs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 14:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751974AbWI1SPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 14:15:48 -0400
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:40637 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751973AbWI1SPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 14:15:47 -0400
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 25 of 28] IB/ipath - Set CPU affinity early
X-Message-Flag: Warning: May contain useful information
References: <4269068599c270538c2e.1159459221@eng-12.pathscale.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 28 Sep 2006 11:15:45 -0700
In-Reply-To: <4269068599c270538c2e.1159459221@eng-12.pathscale.com> (Bryan O'Sullivan's message of "Thu, 28 Sep 2006 09:00:21 -0700")
Message-ID: <adak63n5032.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 28 Sep 2006 18:15:46.0595 (UTC) FILETIME=[1E77FF30:01C6E32A]
Authentication-Results: sj-dkim-2.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > +// Get port early, so can set affinity prior to memory allocation

C++ style comments are frowned on in the kernel.

I fixed all the new ones up to "/* */" style when applying the
patches.
