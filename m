Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932360AbWCFVfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbWCFVfg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 16:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbWCFVfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 16:35:36 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:65396 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S932360AbWCFVff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 16:35:35 -0500
X-IronPort-AV: i="4.02,168,1139212800"; 
   d="scan'208"; a="259900169:sNHT59701156"
To: "Sean Hefty" <sean.hefty@intel.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <openib-general@openib.org>
Subject: Re: [PATCH 6/6] IB: userspace support for RDMA connection manager
X-Message-Flag: Warning: May contain useful information
References: <ORSMSX4011XvpFVjCRG00000009@orsmsx401.amr.corp.intel.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 06 Mar 2006 13:35:27 -0800
In-Reply-To: <ORSMSX4011XvpFVjCRG00000009@orsmsx401.amr.corp.intel.com> (Sean Hefty's message of "Mon, 6 Mar 2006 11:21:04 -0800")
Message-ID: <adak6b75k9s.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 06 Mar 2006 21:35:27.0676 (UTC) FILETIME=[E2A75FC0:01C64165]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think it makes sense to merge patches 1-5 independently of this
patch.  The kernel interface is needed by iSER and NFS/RDMA, and
maintaining compatibility isn't a huge deal, so we can merge it now
(assuming it looks mergable).

On the other hand I think it would be good to let this userspace
interface cook a little more, say in -mm.

Anyone have any problems with that plan?

 - R.
