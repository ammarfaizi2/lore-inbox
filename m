Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751169AbWGKSEt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbWGKSEt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 14:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbWGKSEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 14:04:49 -0400
Received: from mga02.intel.com ([134.134.136.20]:39035 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751169AbWGKSEs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 14:04:48 -0400
X-IronPort-AV: i="4.06,223,1149490800"; 
   d="scan'208"; a="63600465:sNHT12700329418"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: Re: Intel ICH7 82801GBM/GHM
Date: Tue, 11 Jul 2006 10:59:17 -0700
Message-ID: <39B20DF628532344BC7A2692CB6AEE070A683F@orsmsx420.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Re: Intel ICH7 82801GBM/GHM
Thread-Index: AcalE7qArdAmGO8qSoSbtyev3SFvXQ==
From: "Gaston, Jason D" <jason.d.gaston@intel.com>
To: <bojan@rexursive.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 11 Jul 2006 17:59:18.0826 (UTC) FILETIME=[BB1428A0:01C6A513]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bojan,

27c4 is the ICH7M SATA (IDE mode) controller DeviceID.

If you change the mode from IDE to AHCI in BIOS, this will change to
27c5, which is the ICH7M SATA (AHCI mode) controller DeviceID.

Jason


> Does anyone know if this chip, which goes by PCI ID 8086:27c4 (as
listed 
> in ata_piix.c) is something that ahci.c can also drive? It isn't
listed 
> explicity in ahci.c file, but ata_piix.c file says it's identical to 
> ICH6M, which is listed in ahci.c.

