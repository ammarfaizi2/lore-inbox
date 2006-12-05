Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968372AbWLEF1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968372AbWLEF1X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 00:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967723AbWLEF1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 00:27:21 -0500
Received: from sj-iport-6.cisco.com ([171.71.176.117]:24994 "EHLO
	sj-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967562AbWLEF1S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 00:27:18 -0500
X-IronPort-AV: i="4.09,496,1157353200"; 
   d="scan'208"; a="89749087:sNHT41335038"
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Steve Wise <swise@opengridcomputing.com>, netdev@vger.kernel.org,
       openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH  v2 04/13] Connection Manager
X-Message-Flag: Warning: May contain useful information
References: <20061202224917.27014.15424.stgit@dell3.ogc.int>
	<20061202224958.27014.65970.stgit@dell3.ogc.int>
	<20061204110825.GA26251@2ka.mipt.ru> <ada8xhnk6kv.fsf@cisco.com>
	<20061205050725.GA26033@2ka.mipt.ru> <ada3b7uhqlk.fsf@cisco.com>
	<20061205051657.GB26845@2ka.mipt.ru>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 04 Dec 2006 21:27:09 -0800
In-Reply-To: <20061205051657.GB26845@2ka.mipt.ru> (Evgeniy Polyakov's message of "Tue, 5 Dec 2006 08:16:58 +0300")
Message-ID: <aday7pmgbf6.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 05 Dec 2006 05:27:12.0109 (UTC) FILETIME=[042ED9D0:01C7182E]
Authentication-Results: sj-dkim-8; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim8002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > So will each new NIC implement some parts of TCP stack in theirs drivers?

I hope not.  The driver we merged (amso1100) did it completely in FW,
with a separate MAC and IP interface for the RDMA connections.  I
think we better understand the Chelsio driver pretty well and think it
over carefully before we merge it.

Thanks for pointing this stuff out.

 - R.
