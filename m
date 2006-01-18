Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030359AbWARPoh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030359AbWARPoh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 10:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030356AbWARPog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 10:44:36 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:61351 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S1030351AbWARPof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 10:44:35 -0500
X-IronPort-AV: i="3.99,381,1131350400"; 
   d="scan'208"; a="393171253:sNHT35477368"
To: "Sean Hefty" <sean.hefty@intel.com>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
       openib-general@openib.org
Subject: Re: [openib-general] [PATCH 5/5] [RFC] Infiniband: connection
 abstraction
X-Message-Flag: Warning: May contain useful information
References: <ORSMSX401yEXUIEAOeI00000043@orsmsx401.amr.corp.intel.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 18 Jan 2006 07:44:33 -0800
In-Reply-To: <ORSMSX401yEXUIEAOeI00000043@orsmsx401.amr.corp.intel.com> (Sean
 Hefty's message of "Tue, 17 Jan 2006 15:44:48 -0800")
Message-ID: <adar775wnfi.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 18 Jan 2006 15:44:33.0423 (UTC) FILETIME=[13ED11F0:01C61C46]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > +	UCMA_MAX_BACKLOG	= 128

Is there any reason that we might want to make this a tunable?  Maybe
as a module parameter that's writable in sysfs...

 - R.
