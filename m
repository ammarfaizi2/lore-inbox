Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751107AbVJHTRf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbVJHTRf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 15:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbVJHTRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 15:17:35 -0400
Received: from hqemgate01.nvidia.com ([216.228.112.170]:25626 "EHLO
	HQEMGATE01.nvidia.com") by vger.kernel.org with ESMTP
	id S1751096AbVJHTRe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 15:17:34 -0400
x-mimeole: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Anybody know about nforce4 SATA II hot swapping + linux raid?
Date: Sat, 8 Oct 2005 12:16:59 -0700
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B00B41CA30@hqemmail02.nvidia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Anybody know about nforce4 SATA II hot swapping + linux raid?
Thread-Index: AcXL28tuFSO9LbBVTvWFtf38HJU6bQAYKtTA
From: "Allen Martin" <AMartin@nvidia.com>
To: "Tejun Heo" <htejun@gmail.com>, "Andrew Walrond" <andrew@walrond.org>
Cc: <linux-raid@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 08 Oct 2005 19:16:51.0880 (UTC) FILETIME=[D680DA80:01C5CC3C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   One more thing to note is that nVidia cannot supply information
> regarding SATA part (I think network part too) of its chipset to open
> source community.  So, it is possible that not everything goes
smoothly
> with nf4 hotplug support even after other pieces come together
eventually.

The sata_nv libata driver has had full support for hotplug for a while.
When the rest of libata supports hotplug nForce4 SATA hotplug should
just work.

-Allen
