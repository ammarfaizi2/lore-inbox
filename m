Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263192AbUJ2J4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263192AbUJ2J4l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 05:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263191AbUJ2J4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 05:56:41 -0400
Received: from fmr05.intel.com ([134.134.136.6]:27612 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S263192AbUJ2Jz3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 05:55:29 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] [swsusp] print error message when swapping is disabled
Date: Fri, 29 Oct 2004 17:54:42 +0800
Message-ID: <16A54BF5D6E14E4D916CE26C9AD305756F342F@pdsmsx402.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] [swsusp] print error message when swapping is disabled
Thread-Index: AcS9lzMVvTIVZYNyR5ugwTalzg8ELwABaItw
From: "Li, Shaohua" <shaohua.li@intel.com>
To: "Pavel Machek" <pavel@ucw.cz>, "Zhu, Yi" <yi.zhu@intel.com>
Cc: "Andrew Morton" <akpm@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 29 Oct 2004 09:54:43.0743 (UTC) FILETIME=[50DD92F0:01C4BD9D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>> > Another case is PSE disabled. Should notify this to user also.
>>
>> Here is a patch to address it.
>
>Patch is okay (but I rararely see this kind of failure in
>wild). Please submit via akpm.
>
Enable DEBUG_PAGEALLOC will disable PSE. 
Possibly a stupid question, why swsusp need PSE? I didn't see any
relationship between the two.

Thanks,
Shaohua
