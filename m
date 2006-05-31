Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965111AbWEaTRb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965111AbWEaTRb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 15:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965109AbWEaTRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 15:17:31 -0400
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:4269 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S965105AbWEaTRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 15:17:30 -0400
X-IronPort-AV: i="4.05,194,1146466800"; 
   d="scan'208"; a="323918651:sNHT29608936"
To: Steve Wise <swise@opengridcomputing.com>
Cc: mshefty@ichips.intel.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 2/2] iWARP Core Changes.
X-Message-Flag: Warning: May contain useful information
References: <20060531182650.3308.81538.stgit@stevo-desktop>
	<20060531182654.3308.41372.stgit@stevo-desktop>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 31 May 2006 12:17:26 -0700
In-Reply-To: <20060531182654.3308.41372.stgit@stevo-desktop> (Steve Wise's message of "Wed, 31 May 2006 13:26:55 -0500")
Message-ID: <adaodxeypfd.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 31 May 2006 19:17:29.0321 (UTC) FILETIME=[DBE52590:01C684E6]
Authentication-Results: sj-dkim-3.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > +EXPORT_SYMBOL(copy_addr);

I think if you want to export this, it needs a less generic name
(something with an rdma_ prefix probably).  Otherwise it's going to
collide someday...
