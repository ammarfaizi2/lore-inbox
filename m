Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262456AbVAZXUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262456AbVAZXUc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 18:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262455AbVAZXTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 18:19:34 -0500
Received: from fmr18.intel.com ([134.134.136.17]:19931 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S262457AbVAZR66 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 12:58:58 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: PCI Express MSI in kernel 2.4 ?
Date: Wed, 26 Jan 2005 09:58:52 -0800
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E50240795BF7E@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PCI Express MSI in kernel 2.4 ?
Thread-Index: AcUDdOEbiZs1kj1TTbCm5TcEb81q0wAToAMA
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "philippe marteau" <Philippe.MARTEAU@alcatel.fr>,
       <linux-kernel@vger.kernel.org>
Cc: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
X-OriginalArrivalTime: 26 Jan 2005 17:58:52.0615 (UTC) FILETIME=[B21B6D70:01C503D0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, January 25, 2005 10:59 PM Philippe Marteau wrote:
> I saw that there is an implementation of MSI in the Linux kernel 2.6 
> stream.
>
> Is there a possibility to port this in the 2.4 kernel tree (we are at 
> this time using 2.4.17) ?
>
> Is this already foreseen and planned and when ?
There is no patch for 2.4 and we have no plans to do one.

> Is this MSI feature already used out there ? on which target processor

> and southbridge ?
Chipsets have been shipping with MSI support for several years. The
major dependency is if the PCI card you want to enable supports MSI.

Thanks,
Long
