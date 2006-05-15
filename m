Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751510AbWEOPpw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbWEOPpw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 11:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbWEOPpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 11:45:52 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:35888 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S1751510AbWEOPpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 11:45:51 -0400
X-IronPort-AV: i="4.05,130,1146466800"; 
   d="scan'208"; a="1806303880:sNHT29589284"
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4 of 53] ipath - cap number of PDs that can be allocated
X-Message-Flag: Warning: May contain useful information
References: <300f0aa6f034eec6a806.1147477369@eng-12.pathscale.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 15 May 2006 08:45:49 -0700
In-Reply-To: <300f0aa6f034eec6a806.1147477369@eng-12.pathscale.com> (Bryan O'Sullivan's message of "Fri, 12 May 2006 16:42:49 -0700")
Message-ID: <adapsifuw9e.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 15 May 2006 15:45:49.0909 (UTC) FILETIME=[A3D8A850:01C67836]
Authentication-Results: sj-dkim-4.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Put an arbitrary cap on the maximum number of PDs that can be allocated
 > for a device.  This is arbitrary because the number we support
 > is constrained only by system memory and what kmalloc can give us.
 > Nevertheless, if we don't have a limit, some third-party  OpenIB stress
 > tests fail.  The limit can be changed on the fly using a module parameter.

Would it make more sense to fix the stress test?

 - R.
