Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263149AbTC1V3E>; Fri, 28 Mar 2003 16:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263150AbTC1V3E>; Fri, 28 Mar 2003 16:29:04 -0500
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:16651 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S263149AbTC1V3D> convert rfc822-to-8bit; Fri, 28 Mar 2003 16:29:03 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: PCI question
Date: Fri, 28 Mar 2003 15:40:14 -0600
Message-ID: <45B36A38D959B44CB032DA427A6E106404744CA8@cceexc18.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PCI question
Thread-Index: AcL1cMZo0OOWArztSJKoNd0JqLB2pgAAYIhw
From: "Cameron, Steve" <Steve.Cameron@hp.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 28 Mar 2003 21:40:14.0811 (UTC) FILETIME=[9E2532B0:01C2F572]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I wrote:
> Is it possible for a driver to know the size of each 
> the BARs which struct pci_dev->resource[x].start corresponds with?
[...]
> drivers/pci/pci.c:read_pci_bases() looks like it tests
> to see if BARs are 32 or 64 bit, but does not save this
> information in pci_dev->resource[x],[...]

Duh!  Now I see where it saves it in resource[x]->flags...
The low bits tell me this information.  (Sorry about the noise.)

-- steve
