Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261561AbVEAIvo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbVEAIvo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 04:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbVEAIvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 04:51:43 -0400
Received: from fmr17.intel.com ([134.134.136.16]:48024 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S261561AbVEAIvc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 04:51:32 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.12-rc3-mm1
Date: Sun, 1 May 2005 16:49:14 +0800
Message-ID: <16A54BF5D6E14E4D916CE26C9AD3057501D94959@pdsmsx402.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.12-rc3-mm1
Thread-Index: AcVNvWTj9rgsi9f4TjKaaeeAvHU2fgAa690Q
From: "Li, Shaohua" <shaohua.li@intel.com>
To: "Andrew Morton" <akpm@osdl.org>, "Coywolf Qi Hunt" <coywolf@lovecn.org>
Cc: <coywolf@gmail.com>, <zwane@arm.linux.org.uk>,
       <linux-kernel@vger.kernel.org>, <ak@muc.de>, <bunk@stusta.de>
X-OriginalArrivalTime: 01 May 2005 08:49:16.0052 (UTC) FILETIME=[A7C97D40:01C54E2A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Thanks, guys.  I seem to have it limping along on UP now, partly with
the
>below.
>
>Li, it's a bit awkward to be calling things by hand on SMP and with an
>initcall on UP.  Maybe something neater can be done there.
>
>I quickly tested suspend/resume on UP.  Appears to work.
Thanks for fixing this. I apparently forgot testing it in UP, very sorry
for this. Yes, an initcall possibly isn't good. I'm now on vocation for
Chinese Labor holiday till May 7, so I might have no time to do it
before returning to office.

Thanks,
Shaohua
