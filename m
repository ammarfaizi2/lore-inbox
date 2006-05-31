Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964871AbWEaUcs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964871AbWEaUcs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 16:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964851AbWEaUcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 16:32:48 -0400
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:40108 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S964821AbWEaUcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 16:32:46 -0400
X-IronPort-AV: i="4.05,194,1146466800"; 
   d="scan'208"; a="429444928:sNHT33796698"
To: Steve Wise <swise@opengridcomputing.com>
Cc: mshefty@ichips.intel.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 2/2] iWARP Core Changes.
X-Message-Flag: Warning: May contain useful information
References: <20060531182650.3308.81538.stgit@stevo-desktop>
	<20060531182654.3308.41372.stgit@stevo-desktop>
	<adaodxeypfd.fsf@cisco.com> <1149107435.7469.7.camel@stevo-desktop>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 31 May 2006 13:32:44 -0700
In-Reply-To: <1149107435.7469.7.camel@stevo-desktop> (Steve Wise's message of "Wed, 31 May 2006 15:30:35 -0500")
Message-ID: <adad5dux7df.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 31 May 2006 20:32:45.0321 (UTC) FILETIME=[5FA40F90:01C684F1]
Authentication-Results: sj-dkim-3.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Steve> The function is needed by the iwcm module, so that's why we
    Steve> exported it.  I could change the name to rdma_copy_addr(),
    Steve> or make the function a static inline in a header file since
    Steve> its kinda small anyway...

It looks too big to inline to me, and I don't think it's on a fast
path anyway.  So I would export it.

 - R.
