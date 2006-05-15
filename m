Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbWEOXQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbWEOXQs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 19:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbWEOXQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 19:16:48 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:37690 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S1750733AbWEOXQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 19:16:47 -0400
X-IronPort-AV: i="4.05,131,1146466800"; 
   d="scan'208"; a="277196760:sNHT30902798"
To: Grant Grundler <iod00d@hp.com>
Cc: "Bryan O'Sullivan" <bos@pathscale.com>,
       Segher Boessenkool <segher@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH 21 of 53] ipath - use phys_to_virt instead of bus_to_virt
X-Message-Flag: Warning: May contain useful information
References: <4e0a07d20868c6c4f038.1147477386@eng-12.pathscale.com>
	<adad5efuw1o.fsf@cisco.com>
	<1147728081.2773.25.camel@chalcedony.pathscale.com>
	<adar72vrn8y.fsf@cisco.com> <20060515231342.GK29082@esmail.cup.hp.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 15 May 2006 16:16:45 -0700
In-Reply-To: <20060515231342.GK29082@esmail.cup.hp.com> (Grant Grundler's message of "Mon, 15 May 2006 16:13:42 -0700")
Message-ID: <ada1wuuswte.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 15 May 2006 23:16:46.0583 (UTC) FILETIME=[A2E17870:01C67875]
Authentication-Results: sj-dkim-1.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Grant> Or figure out which openib.org interface has to change so
    Grant> the original virt addresses that were registered/handed to
    Grant> the ULP are passed down to the low level interface driver
    Grant> too.  Seems like a more obvious way to fix the problem.
    Grant> Someone did suggest this already, right?

It's been suggested many times, but no one ever comes up with a way to
handle the fact that RDMA means that addresses come from remote
systems as well as being passed in through an API.

 - R.
