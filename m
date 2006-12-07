Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031855AbWLGIi7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031855AbWLGIi7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 03:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031856AbWLGIi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 03:38:59 -0500
Received: from soda.ext.ti.com ([198.47.26.145]:39721 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031855AbWLGIi6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 03:38:58 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [2.6.18]make menuconfig:USB Gadget Drivers are  selected as modules instead of Y by default during menuconfig
Date: Thu, 7 Dec 2006 14:08:31 +0530
Message-ID: <F6FE727D1D69E340844C253265136D5D0223D4A3@dbde01.ent.ti.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.6.18]make menuconfig:USB Gadget Drivers are  selected as modules instead of Y by default during menuconfig
Thread-Index: AccZ2xMFHSCWOeXaSgejIIAtHopfxA==
From: "Shah, Hardik" <hardik.s@ti.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have one problem with menuconfig in linux 2.6.18.  Description is as
below.

make menuconfig
(Go to) 
Device Drivers  --->
     USB support  --->
           USB Gadget Support  --->
Select Support for USB Gadgets as 'Y'

"USB Gadget Drivers" is selected as 'M' by default.  But USB Gadget
Drivers is a choice type menu which depends on "Support for USB Gadgets"
&& "USB_GADGET_SELECT"

Since "Support for USB Gadgets" is selected as 'Y' and
"USB_GADGET_SELECT" is also 'Y' "USB Gadget Drivers" should also be
selected as 'Y' by default.  But it is selected as 'M' by default and it
also allows to choose multiple gadgets although it is a choice menu.  So
can anyone please let me know the solution for fixing this problem?

Thanks
Hardik

