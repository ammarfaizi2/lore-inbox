Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932373AbWCFVmc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbWCFVmc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 16:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbWCFVma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 16:42:30 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:60647
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932370AbWCFVmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 16:42:24 -0500
Date: Mon, 06 Mar 2006 13:42:34 -0800 (PST)
Message-Id: <20060306.134234.61724983.davem@davemloft.net>
To: rdreier@cisco.com
Cc: sean.hefty@intel.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH 3/6] net/IB: export ip_dev_find
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <adaslpv5kh2.fsf@cisco.com>
References: <ORSMSX4011XvpFVjCRG00000006@orsmsx401.amr.corp.intel.com>
	<adaslpv5kh2.fsf@cisco.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 06 Mar 2006 13:31:05 -0800

>     Sean> Export ip_dev_find to allow locating a net_device given an
>     Sean> IP address.
> 
> My plan is to queue all of this stuff for merging in 2.6.17.
> 
> Is there any objection from netdev or openib-general people?
> 
> I just looked back, and the original "unexport ip_dev_find()" patch
> was a de-Bunk-ing change.  Now that there is a modular user, is there
> any problem with re-exporting it?

I'm fine with re-exporting it.
