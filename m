Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751059AbWBVCkf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbWBVCkf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 21:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbWBVCkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 21:40:35 -0500
Received: from fmr18.intel.com ([134.134.136.17]:48069 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751059AbWBVCke convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 21:40:34 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.16-rc4: known regressions
Date: Wed, 22 Feb 2006 10:39:01 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F840AFD52B2@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.16-rc4: known regressions
thread-index: AcY0GEXedeZ4agKQQlO0NaXvfi2vzwDQJBHQ
From: "Yu, Luming" <luming.yu@intel.com>
To: "Adrian Bunk" <bunk@stusta.de>, "Linus Torvalds" <torvalds@osdl.org>,
       "Andrew Morton" <akpm@osdl.org>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "John Stultz" <johnstul@us.ibm.com>, <paulus@samba.org>,
       <linuxppc-dev@ozlabs.org>, <gregkh@suse.de>,
       "Sanjoy Mahajan" <sanjoy@mrao.cam.ac.uk>,
       "Brown, Len" <len.brown@intel.com>, <linux-acpi@vger.kernel.org>,
       "Meelis Roos" <mroos@linux.ee>,
       "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
       <linux-input@atrey.karlin.mff.cuni.cz>
X-OriginalArrivalTime: 22 Feb 2006 02:39:02.0842 (UTC) FILETIME=[245E61A0:01C63759]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Subject    : S3 sleep hangs the second time - 600X
>References : http://bugzilla.kernel.org/show_bug.cgi?id=5989
>Submitter  : Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
>Status     : problematic commit identified,
>             further discussion is in the bug

The real problem is there are some bugs hidden by ec_intr=0.
ec_intr=1 just get these bug  just exposed, and we need to fix them. 

Thanks,
Luming
