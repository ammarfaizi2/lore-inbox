Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272766AbTG3GwN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 02:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272785AbTG3GwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 02:52:13 -0400
Received: from fmr06.intel.com ([134.134.136.7]:12760 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S272766AbTG3GwL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 02:52:11 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: e1000 performance
Date: Tue, 29 Jul 2003 23:52:07 -0700
Message-ID: <C6F5CF431189FA4CBAEC9E7DD5441E0102229232@orsmsx402.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: e1000 performance
Thread-Index: AcNVV60GRHnB/C/7QaWWyXQBM3habABDvG1A
From: "Feldman, Scott" <scott.feldman@intel.com>
To: "J.A. Magallon" <jamagallon@able.es>,
       "Lista Linux-Kernel" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 30 Jul 2003 06:52:08.0128 (UTC) FILETIME=[1807A400:01C35667]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think I am getting weird performace with e1000 in 2.4.22-pre.

Is this behavior new to 2.4.22-pre?

> Hardware:
> 03:01.0 Ethernet controller: Intel Corp. 82543GC Gigabit 
> Ethernet Controller (Copper) (rev 02)

82543 = PCI, not PCI-X.  Are you in a 64-bit slot?  Get ethtool 1.8 and
run ethtool -d eth<x> to see PCI type/width/speed.
 
-scott
