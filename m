Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267497AbUI1CaB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267497AbUI1CaB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 22:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267509AbUI1CaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 22:30:00 -0400
Received: from fmr05.intel.com ([134.134.136.6]:20151 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S267497AbUI1C3C convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 22:29:02 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: suspend/resume support for driver requires an external firmware
Date: Tue, 28 Sep 2004 10:28:46 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8403BD579D@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: suspend/resume support for driver requires an external firmware
Thread-Index: AcSk5rWBJ01Cs6ZeRhu2KPVvfHQEtQAGFpiw
From: "Zhu, Yi" <yi.zhu@intel.com>
To: "Dmitry Torokhov" <dtor_core@ameritech.net>,
       <linux-kernel@vger.kernel.org>
Cc: "Denis Vlasenko" <vda@port.imtp.ilyichevsk.odessa.ua>,
       "Oliver Neukum" <oliver@neukum.org>,
       "Patrick Mochel" <mochel@digitalimplant.org>
X-OriginalArrivalTime: 28 Sep 2004 02:28:47.0205 (UTC) FILETIME=[E1EBA150:01C4A502]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> Where do you load your firmware from so that you can bring up
> the network so you can mount everything via NFS in the first place?

The firmware locates together w/ the driver in the initrd which could be
either in the remote PXE server or the local diskettes. It should be
also
placed somewhere on the NFS root so that it can be picked up to
memory during suspend.

Thanks,
-yi
