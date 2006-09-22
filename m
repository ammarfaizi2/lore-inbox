Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932488AbWIVP1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932488AbWIVP1y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 11:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932515AbWIVP1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 11:27:54 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:54103 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S932488AbWIVP1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 11:27:53 -0400
X-IronPort-AV: i="4.09,203,1157353200"; 
   d="scan'208"; a="1854897615:sNHT31960444"
To: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
Cc: rolandd@cisco.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       openib-general@openib.org, openfabrics-ewg@openib.org, pmac@au1.ibm.com,
       raisch@de.ibm.com
Subject: Re: [PATCH 2.6.19-rc1] ehca firmware interface based on Anton Blanchard's new hvcall interface
X-Message-Flag: Warning: May contain useful information
References: <200609221720.24191.hnguyen@de.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 22 Sep 2006 08:27:49 -0700
In-Reply-To: <200609221720.24191.hnguyen@de.ibm.com> (Hoang-Nam Nguyen's message of "Fri, 22 Sep 2006 17:20:23 +0200")
Message-ID: <ada7izvhqfe.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 22 Sep 2006 15:27:50.0767 (UTC) FILETIME=[AA5427F0:01C6DE5B]
Authentication-Results: sj-dkim-5.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > - shca->ib_device.node_type           = RDMA_NODE_IB_CA;
 > + shca->ib_device.node_type           = IB_NODE_CA;

Did you test this at all?  I can't see how this would build against my
for-2.6.19 tree...

Please resend a patch that you know is working.

 - R.
