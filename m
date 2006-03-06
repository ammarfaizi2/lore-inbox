Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932362AbWCFVbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbWCFVbM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 16:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932359AbWCFVbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 16:31:12 -0500
Received: from test-iport-1.cisco.com ([171.71.176.117]:11137 "EHLO
	test-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S932355AbWCFVbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 16:31:11 -0500
To: "Sean Hefty" <sean.hefty@intel.com>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
       <openib-general@openib.org>
Subject: Re: [PATCH 3/6] net/IB: export ip_dev_find
X-Message-Flag: Warning: May contain useful information
References: <ORSMSX4011XvpFVjCRG00000006@orsmsx401.amr.corp.intel.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 06 Mar 2006 13:31:05 -0800
In-Reply-To: <ORSMSX4011XvpFVjCRG00000006@orsmsx401.amr.corp.intel.com> (Sean Hefty's message of "Mon, 6 Mar 2006 11:07:44 -0800")
Message-ID: <adaslpv5kh2.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 06 Mar 2006 21:31:06.0780 (UTC) FILETIME=[4725CDC0:01C64165]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Sean> Export ip_dev_find to allow locating a net_device given an
    Sean> IP address.

My plan is to queue all of this stuff for merging in 2.6.17.

Is there any objection from netdev or openib-general people?

I just looked back, and the original "unexport ip_dev_find()" patch
was a de-Bunk-ing change.  Now that there is a modular user, is there
any problem with re-exporting it?

Thanks,
  Roland
