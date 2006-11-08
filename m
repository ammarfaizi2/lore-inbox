Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161727AbWKHWGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161727AbWKHWGp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 17:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161483AbWKHWGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 17:06:45 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:49512 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S1161361AbWKHWGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 17:06:43 -0500
X-IronPort-AV: i="4.09,401,1157353200"; 
   d="scan'208"; a="449163056:sNHT47443276"
To: Christoph Raisch <RAISCH@de.ibm.com>
Cc: Hoang-Nam Nguyen <hnguyen@de.ibm.com>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, openib-general@openib.org, rolandd@cisco.com
Subject: Re: [PATCH 2.6.19 2/4] ehca: hcp_phyp.c: correct page mapping in 64k page mode
X-Message-Flag: Warning: May contain useful information
References: <OF60EFC2CD.F8FB1D23-ONC1257220.00315F90-C1257220.0038B8E3@de.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 08 Nov 2006 14:06:42 -0800
In-Reply-To: <OF60EFC2CD.F8FB1D23-ONC1257220.00315F90-C1257220.0038B8E3@de.ibm.com> (Christoph Raisch's message of "Wed, 8 Nov 2006 11:22:27 +0100")
Message-ID: <adaejsdfv9p.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 08 Nov 2006 22:06:42.0720 (UTC) FILETIME=[2C4CA200:01C70382]
Authentication-Results: sj-dkim-1.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > We plan to change that as soon as the base kernel can handle mixed
 > pagesizes in a more official way.

OK, so this is just a temporary workaround for powerpc's broken ioremap()?

I'll apply for 2.6.19, and I hope we can back this out in 2.6.20.

 - R.
