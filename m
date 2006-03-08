Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751803AbWCHBej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751803AbWCHBej (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 20:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751833AbWCHBej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 20:34:39 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:900 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S1751803AbWCHBei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 20:34:38 -0500
X-IronPort-AV: i="4.02,173,1139212800"; 
   d="scan'208"; a="413328104:sNHT33222516"
To: "David S. Miller" <davem@davemloft.net>
Cc: mlleinin@hpcn.ca.sandia.gov, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org,
       shemminger@osdl.org
Subject: Re: [openib-general] Re: TSO and IPoIB performance degradation
X-Message-Flag: Warning: May contain useful information
References: <1141776697.6119.938.camel@localhost>
	<20060307.161808.60227862.davem@davemloft.net>
	<adaacc1raz9.fsf@cisco.com>
	<20060307.172336.107863253.davem@davemloft.net>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 07 Mar 2006 17:34:34 -0800
In-Reply-To: <20060307.172336.107863253.davem@davemloft.net> (David S. Miller's message of "Tue, 07 Mar 2006 17:23:36 -0800 (PST)")
Message-ID: <ada4q29ra6t.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 08 Mar 2006 01:34:34.0940 (UTC) FILETIME=[74B3DFC0:01C64250]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    David> I wish you had started the thread by mentioning this
    David> specific patch, we wasted an enormous amount of precious
    David> developer time speculating and asking for arbitrary tests
    David> to be run in order to narrow down the problem, yet you knew
    David> the specific change that introduced the performance
    David> regression already...

Sorry, you're right.  I was a little confused because I had a memory of
Michael's original email (http://lkml.org/lkml/2006/3/6/150) quoting a
changelog entry, but looking back at the message, it was quoting
something completely different and misleading.

I think the most interesting email in the old thread is
http://openib.org/pipermail/openib-general/2005-October/012482.html
which shows that reverting 314324121 (the "stretch ACK performance
killer" fix) gives ~400 Mbit/sec in extra IPoIB performance.

 - R.
