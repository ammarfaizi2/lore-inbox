Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267315AbUHDRB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267315AbUHDRB7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 13:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267314AbUHDRB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 13:01:59 -0400
Received: from fmr05.intel.com ([134.134.136.6]:5549 "EHLO hermes.jf.intel.com")
	by vger.kernel.org with ESMTP id S267312AbUHDRB4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 13:01:56 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: CONFIG_FORCE_MAX_ZONEORDER
Date: Wed, 4 Aug 2004 09:30:35 -0700
Message-ID: <01EF044AAEE12F4BAAD955CB7506494301FB54AB@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: CONFIG_FORCE_MAX_ZONEORDER
Thread-Index: AcR6KMKJVfCAii5BRFCjT7nck8t+RAAF3JBw
From: "Seth, Rohit" <rohit.seth@intel.com>
To: "Sourav Sen" <souravs@india.hp.com>, <linux-kernel@vger.kernel.org>,
       <linux-ia64@vger.kernel.org>
X-OriginalArrivalTime: 04 Aug 2004 16:30:35.0929 (UTC) FILETIME=[5EBF0890:01C47A40]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sourav Sen <> wrote on Wednesday, August 04, 2004 6:39 AM:

> Hi,
> 
> Is there a way of changing the value of MAX_ORDER
> using CONFIG_FORCE_MAX_ZOMEORDER? During 'make xconfig'
> I did not see a way. If I change it by hand in .config
> and then run make oldconfig, it gets changed back to
> the old value (== 18). The source version is 2.6.6
> 
> And, if it matters here -- I am on ia64.
> 
> Thanks
> Sourav
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ia64"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


arch/ia64/defconfig is the place where you want to make the change.
