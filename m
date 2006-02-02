Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbWBBRhe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbWBBRhe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 12:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbWBBRhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 12:37:33 -0500
Received: from amdext3.amd.com ([139.95.251.6]:20961 "EHLO amdext3.amd.com")
	by vger.kernel.org with ESMTP id S1750811AbWBBRhd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 12:37:33 -0500
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: powernow-k8: out of sync on Athlon64 x2 3800+
Date: Thu, 2 Feb 2006 11:36:05 -0600
Message-ID: <B3870AD84389624BAF87A3C7B831499302935525@SAUSEXMB2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: powernow-k8: out of sync on Athlon64 x2 3800+
Thread-Index: AcYnw3SZVA05fX4SSdmDHI3yyZv0dQAUDrQg
From: "shin, jacob" <jacob.shin@amd.com>
To: "Andi Kleen" <ak@suse.de>
cc: cpufreq@lists.linux.org.uk, linux-kernel@vger.kernel.org,
       "Langsdorf, Mark" <mark.langsdorf@amd.com>,
       "Niklas Edmundsson" <Niklas.Edmundsson@hpc2n.umu.se>,
       Andreas.Burghart@fujitsu-siemens.com
X-OriginalArrivalTime: 02 Feb 2006 17:36:06.0822 (UTC)
 FILETIME=[25B2F460:01C6281F]
X-WSS-ID: 6FFC9C8D1F44656696-01-01
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, February 02, 2006 12:38 AM Andi Kleen wrote:
> It's in 2.6.16-rc1. If you think it's critical I can propose it for 2.6.15
> stable too.

Yes, please do propose it for 2.6.15 as well.

It is critical in my opinion.  It affects all i386 kernel running AMD Dual-Core processors.  It affects any code that relies on cpu_core_id and phys_proc_id data.

I believe the bug has been around since 2.6.13.  I am surprised no one raised red flags until now.  Maybe everyone using dual core processors migrated to x86_64.  ;-)

Thanks Andi,

-Jacob Shin
AMD, Inc.

