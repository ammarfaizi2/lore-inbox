Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbVJGJAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbVJGJAT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 05:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbVJGJAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 05:00:18 -0400
Received: from laf31-5-82-235-130-100.fbx.proxad.net ([82.235.130.100]:15861
	"EHLO lexbox.fr") by vger.kernel.org with ESMTP id S932125AbVJGJAR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 05:00:17 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Write file corruption - The next
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Date: Fri, 7 Oct 2005 10:57:33 +0200
Message-ID: <17AB476A04B7C842887E0EB1F268111E026FF7@xpserver.intra.lexbox.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Write file corruption - The next
thread-index: AcXLHSfBGyjzVGtsRbWw/e4IvECJCQ==
From: "David Sanchez" <david.sanchez@lexbox.fr>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When I copy big file around (500MB) then sometimes the copied file
differs from the source!

I try big copy on an AMD dbau1550 and on an EPIA Mini-ITX board using
several Sata promise controllers (with DMA and without DMA) and using
the IDE interface (with DMA and without DMA) and the problem still
appears!!

More I try busybox 1.0 and 1.01 with kernel 2.4 to 2.6.13 and the
problem still appears... memtest tool doesn't detect error...

I don't know what to do... According to my test, the problem seems to
come from a software bug: maybe something wrong in the kernel? But if it
was a kernel bug why it has NOT been detect before? 

Please help me!

David


