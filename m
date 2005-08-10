Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030193AbVHJS7v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030193AbVHJS7v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 14:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030192AbVHJS7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 14:59:51 -0400
Received: from hqemgate01.nvidia.com ([216.228.112.170]:42798 "EHLO
	HQEMGATE01.nvidia.com") by vger.kernel.org with ESMTP
	id S1030193AbVHJS7u convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 14:59:50 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: NCQ support NVidia NForce4 (CK804) SATAII
Date: Wed, 10 Aug 2005 11:59:48 -0700
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B004FAE3E5@hqemmail02.nvidia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: NCQ support NVidia NForce4 (CK804) SATAII
Thread-Index: AcWd2YFZuc18eub+QG6Y9oXjVCG5vgAAyZwg
From: "Allen Martin" <AMartin@nvidia.com>
To: "Michael Thonke" <iogl64nx@gmail.com>, "Jeff Garzik" <jgarzik@pobox.com>
Cc: "linux mailing-list" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 10 Aug 2005 18:59:48.0250 (UTC) FILETIME=[AE000FA0:01C59DDD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Ask NVIDIA.  They are the only company that gives me -zero- 
> > information on their SATA controllers.
> 
> I thought of that.. *sigh*

NVIDIA won't be documenting nForce4 SATA controllers, so Linux NCQ
support for nForce4 is unlikely.  I'm hoping this will change with
future products.

> > As such, there are -zero- plans for NCQ on NVIDIA 
> controllers at this 
> > time.
> 
> Could it be possible to make reverse engeneering? I think they should 
> work as the SATA-IO SATAII specification says.

The SATA-IO SATA-II specification says nothing about host controller
implementations.  Intel documents a host controller implemetnation in
the AHCI specification which is becoming an industry standard, but
nForce4 SATA is not AHCI.

-Allen
