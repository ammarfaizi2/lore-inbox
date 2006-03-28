Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751311AbWC1TpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbWC1TpJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 14:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbWC1TpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 14:45:09 -0500
Received: from mga03.intel.com ([143.182.124.21]:50240 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751311AbWC1TpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 14:45:07 -0500
X-IronPort-AV: i="4.03,139,1141632000"; 
   d="scan'208"; a="15909109:sNHT11658884965"
From: "Bob Woodruff" <robert.j.woodruff@intel.com>
To: "'Roland Dreier'" <rdreier@cisco.com>, <openib-general@openib.org>,
       <linux-kernel@vger.kernel.org>
Subject: RE: [openib-general] InfiniBand 2.6.17 merge plans
Date: Tue, 28 Mar 2006 10:47:36 -0800
Message-ID: <000001c65298$170359c0$010fa8c0@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcZR2MD/qxqEIZkISGey8phJRHf05QAvoqUg
In-Reply-To: <ada7j6f8xwi.fsf@cisco.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
X-OriginalArrivalTime: 28 Mar 2006 18:47:40.0622 (UTC) FILETIME=[174F56E0:01C65298]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland wrote, 
>   - userspace RDMA CM, which exports the abstraction to userspace.
>     The feeling is that this interface needs more time to mature.

The userspace RDMA-CM is currently being used by uDAPL and seems to 
work fine for that application. Our testing so far shows that the code is
stable. However, uDAPL also has a socket based mechanism that can used until
the CMA 
is merged. If others think it still needs more time to mature, then uDAPL
has an interim solution.

my 2 cents on this one.

woody
