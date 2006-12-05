Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968369AbWLEFOJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968369AbWLEFOJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 00:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968368AbWLEFOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 00:14:08 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:20171 "EHLO
	sj-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968363AbWLEFOE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 00:14:04 -0500
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Steve Wise <swise@opengridcomputing.com>, netdev@vger.kernel.org,
       openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH  v2 04/13] Connection Manager
X-Message-Flag: Warning: May contain useful information
References: <20061202224917.27014.15424.stgit@dell3.ogc.int>
	<20061202224958.27014.65970.stgit@dell3.ogc.int>
	<20061204110825.GA26251@2ka.mipt.ru> <ada8xhnk6kv.fsf@cisco.com>
	<20061205050725.GA26033@2ka.mipt.ru>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 04 Dec 2006 21:13:59 -0800
In-Reply-To: <20061205050725.GA26033@2ka.mipt.ru> (Evgeniy Polyakov's message of "Tue, 5 Dec 2006 08:07:25 +0300")
Message-ID: <ada3b7uhqlk.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 05 Dec 2006 05:13:59.0474 (UTC) FILETIME=[2BBC5920:01C7182C]
Authentication-Results: sj-dkim-5; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim5002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > It is for iwarp/rdma from description.

Yes, iWARP on top of 10G ethernet.

 > If it is 10ge, then why does it parse incomping packet headers and
 > implements initial tcp state machine?

To establish connections to run RDMA over, I guess.  iWARP is RDMA
over TCP.

 - R.
