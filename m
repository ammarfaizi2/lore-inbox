Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264262AbTKTDCe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 22:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264264AbTKTDCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 22:02:34 -0500
Received: from fmr05.intel.com ([134.134.136.6]:59779 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S264262AbTKTDCd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 22:02:33 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: Intel E1000 and IDE problems
Date: Wed, 19 Nov 2003 19:02:27 -0800
Message-ID: <C6F5CF431189FA4CBAEC9E7DD5441E0102CBDCE4@orsmsx402.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Intel E1000 and IDE problems
Thread-Index: AcOulVvf7Abn7Nw+T/eGtYWdtynfjQAfRuCA
From: "Feldman, Scott" <scott.feldman@intel.com>
To: "Teodor Iacob" <Teodor.Iacob@astral.ro>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 20 Nov 2003 03:02:28.0409 (UTC) FILETIME=[BB5B2290:01C3AF12]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I recently put up 2 intel network adapters:
> 00:09.0 Ethernet controller: Intel Corp. 82545EM Gigabit 
> Ethernet Controller (Copper) (rev 01)
> 00:0b.0 Ethernet controller: Intel Corp. 82545EM Gigabit 
> Ethernet Controller (Copper) (rev 01)
> 
> ( I replaced some Intel PRO1000 Desktop which I had before ) and now
> I get serious problems with the hda disk:

Did you put the 82545 nics in the same slots where you had the desktop
nics?

Are the 82545 nics on the same bus segment as the disk controller?  Are
there any shared interrupts?  See lcpci -vvv.

-scott
