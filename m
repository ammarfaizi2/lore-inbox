Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262829AbVD2QoB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262829AbVD2QoB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 12:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbVD2QnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 12:43:19 -0400
Received: from fmr20.intel.com ([134.134.136.19]:9631 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S262828AbVD2Qmo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 12:42:44 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH]porting lockless mce from x86_64 to i386
Date: Sat, 30 Apr 2005 00:42:01 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84041AC18D@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH]porting lockless mce from x86_64 to i386
Thread-Index: AcVM0AUUEcva+zwoShSWF7On4vDXrQABySSw
From: "Yu, Luming" <luming.yu@intel.com>
To: "Andi Kleen" <ak@muc.de>, "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, "Guo, Racing" <racing.guo@intel.com>
X-OriginalArrivalTime: 29 Apr 2005 16:42:02.0619 (UTC) FILETIME=[5EC09CB0:01C54CDA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Another comment: 
>
>If Luming would not move the mce.c file from x86-64 to i386 then
>his patch would be only 1/4 as big. I dont know why he does this
>anyways, it seems completely pointless.
>
Sounds reasonable. Then, mce.c will the first one linked into i386
Makefile. :-)
Racing, what do you think?

Thanks,
Luming
