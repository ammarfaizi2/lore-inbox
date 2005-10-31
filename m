Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932519AbVJaRuw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932519AbVJaRuw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 12:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932520AbVJaRuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 12:50:52 -0500
Received: from hqemgate01.nvidia.com ([216.228.112.170]:33057 "EHLO
	HQEMGATE01.nvidia.com") by vger.kernel.org with ESMTP
	id S932519AbVJaRuw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 12:50:52 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: PCI-DMA: high address but no IOMMU - nForce4
Date: Mon, 31 Oct 2005 09:50:40 -0800
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B004FAE5EE@hqemmail02.nvidia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PCI-DMA: high address but no IOMMU - nForce4
Thread-Index: AcXeLtEJjJcwueMkQkCiX87Yq2r5hwAFHubg
From: "Allen Martin" <AMartin@nvidia.com>
To: "Matti Aarnio" <matti.aarnio@zmailer.org>, "Andi Kleen" <ak@suse.de>
Cc: "Michael Madore" <michael.madore@gmail.com>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 31 Oct 2005 17:50:41.0093 (UTC) FILETIME=[9BF99F50:01C5DE43]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This board has no AGP at all in it, but it does have lots
> of PCIE, and a bit of PCI-X thrown in for "legacy cards". 
> Somehow that detail breaks things when the machine really
> should use bounce-buffering, or something similar -- I don't
> know if Nvidia  nForce4 chipset does have IOMMU, though...
> 
> If Nvidia did omit such essential piece of hardware from
> a modern chipset, I do find it amazingly short-sighted...
> (Of course they don't yield documentation of the chips to
> public so that I can't quickly verify this detail...)

nForce4 does not contain an IOMMU, neither does any K8 chipset, because
the IOMMU is in the CPU.

-Allen
