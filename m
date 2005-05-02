Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbVEBBCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbVEBBCh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 21:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261393AbVEBBCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 21:02:37 -0400
Received: from fmr18.intel.com ([134.134.136.17]:22737 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261378AbVEBBCg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 21:02:36 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH]porting lockless mce from x86_64 to i386
Date: Mon, 2 May 2005 09:01:53 +0800
Message-ID: <16A54BF5D6E14E4D916CE26C9AD305750162F6F1@pdsmsx402.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH]porting lockless mce from x86_64 to i386
Thread-Index: AcVM0AQluF4gnHUuT92/MO2ZWHjGzgB4l4CA
From: "Guo, Racing" <racing.guo@intel.com>
To: "Andi Kleen" <ak@muc.de>, "Andrew Morton" <akpm@osdl.org>
Cc: "Yu, Luming" <luming.yu@intel.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 02 May 2005 01:01:55.0075 (UTC) FILETIME=[8879B530:01C54EB2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>If Luming would not move the mce.c file from x86-64 to i386 then
>his patch would be only 1/4 as big. I dont know why he does this
>anyways, it seems completely pointless.

mce.c mce.h and mce_intel.c are moved from x86_64 to i386. so the
patch is very big. The motivation is to share mce code between
x86_64 and i386 and avoid duplicate code in x86_64 and i386.
I don't know whether I completely understand what you point.
Correct me if I am wrong.
