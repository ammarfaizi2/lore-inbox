Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbWC0Xxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbWC0Xxf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 18:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWC0Xxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 18:53:34 -0500
Received: from mga03.intel.com ([143.182.124.21]:6972 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S932088AbWC0Xxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 18:53:34 -0500
X-IronPort-AV: i="4.03,136,1141632000"; 
   d="scan'208"; a="15500335:sNHT1450218497"
From: "Sean Hefty" <sean.hefty@intel.com>
To: "'Roland Dreier'" <rdreier@cisco.com>,
       "Sean Hefty" <mshefty@ichips.intel.com>
Cc: <linux-kernel@vger.kernel.org>, <openib-general@openib.org>
Subject: RE: [openib-general] InfiniBand 2.6.17 merge plans
Date: Mon, 27 Mar 2006 15:53:14 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
Thread-Index: AcZR+Wa5wshhfYXuTP2/oy4naSvcwAAAB8uA
In-Reply-To: <adahd5je9ai.fsf@cisco.com>
Message-ID: <ORSMSX401TRqf69aZbL00000022@orsmsx401.amr.corp.intel.com>
X-OriginalArrivalTime: 27 Mar 2006 23:53:14.0648 (UTC) FILETIME=[9CD3F180:01C651F9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>BTW ib_local_sa also uses rdma_wq ... it might be worth fixing that,
>because it actually makes ib_local_sa depend on CONFIG_NET right now
>(since ib_addr can't build without CONFIG_NET).

Yes - I've fixed that as well.

- Sean
