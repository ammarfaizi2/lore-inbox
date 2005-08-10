Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030263AbVHJUxv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030263AbVHJUxv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 16:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030264AbVHJUxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 16:53:51 -0400
Received: from hqemgate03.nvidia.com ([216.228.112.143]:24348 "EHLO
	HQEMGATE03.nvidia.com") by vger.kernel.org with ESMTP
	id S1030263AbVHJUxv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 16:53:51 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: NCQ support NVidia NForce4 (CK804) SATAII
Date: Wed, 10 Aug 2005 13:53:47 -0700
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B004FAE3E7@hqemmail02.nvidia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: NCQ support NVidia NForce4 (CK804) SATAII
Thread-Index: AcWd3zGH0lyb0wvDTLOUUEBviJmdMwADE0HA
From: "Allen Martin" <AMartin@nvidia.com>
To: "Michael Thonke" <iogl64nx@gmail.com>
Cc: "linux mailing-list" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 10 Aug 2005 20:53:47.0535 (UTC) FILETIME=[9A8821F0:01C59DED]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Erm, why they are not willing to support NCQ under Linux...I 
> mean many 
> people using NVIDIA based mainboards. And that against that what I 
> thought NVidia stands for - Linux friendly but seems only that this 
> statement fit on graficcards? Is there no "responsible" person that 
> says...Hello, Linux is a growing market that we need to 
> serve? With full 
> driver/program support?
> 

Likely the only way nForce4 NCQ support could be added under Linux would
be with a closed source binary driver, and no one really wants that,
especially for storage / boot volume.  We decided it wasn't worth the
headache of a binary driver for this one feature.  Future nForce
chipsets will have a redesigned SATA controller where we can be more
open about documenting it.

-Allen
