Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264057AbUD0Mvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264057AbUD0Mvt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 08:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264054AbUD0Mvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 08:51:49 -0400
Received: from [202.125.86.130] ([202.125.86.130]:1153 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S264057AbUD0Mvq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 08:51:46 -0400
Subject: How to handle interrupts  on SMP systems
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date: Tue, 27 Apr 2004 18:12:05 +0530
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Message-ID: <1118873EE1755348B4812EA29C55A9721D6CC7@esnmail.esntechnologies.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: How to handle interrupts  on SMP systems
Thread-Index: AcQsVQumpZFzeXFkTEK/Ju9yBTPKwg==
From: "Srinivas G." <srinivasg@esntechnologies.co.in>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

We developed a driver for PCIHOTLINK card under linux kernel 2.4.18-3.
It was working fine under it. Now our idea is to port it SMP system with
the same kernel. We ported. It was compiled without any problem under
SMP system. But it is not generating any interrupts. We have changed the
Makefile also. We added -D__SMP__ macro and -DCONFIG_SMP macro in
Makefile. No compilation errors. But interrupts are not generating. 

If anybody will have any idea please let me know.

Thanks in advance,

Regards,

Srinivas G

