Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbVL2OEe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbVL2OEe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 09:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbVL2OEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 09:04:34 -0500
Received: from general.keba.co.at ([193.154.24.243]:49893 "EHLO
	helga.keba.co.at") by vger.kernel.org with ESMTP id S1750722AbVL2OEe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 09:04:34 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: Compile error in mm/slab.c with CONFIG_DEBUG_SLAB (2.6.15-rc7-rt1)
Date: Thu, 29 Dec 2005 15:04:32 +0100
Message-ID: <AAD6DA242BC63C488511C611BD51F367323304@MAILIT.keba.co.at>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Compile error in mm/slab.c with CONFIG_DEBUG_SLAB (2.6.15-rc7-rt1)
Thread-Index: AcYMgKbit74RCPj8T3qZokusHb1L2g==
From: "kus Kusche Klaus" <kus@keba.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried to compile 2.6.15-rc7-rt1 with CONFIG_DEBUG_SLAB and got two
compile errors in mm/slab.c (line 2093 and 2239).

Both were caused by WARN_ONs testing a field "nodeid" in "struct slab".
The struct does not contain such a field.

Klaus Kusche
Entwicklung Software - Steuerung
Software Development - Control

KEBA AG
A-4041 Linz
Gewerbepark Urfahr
Tel +43 / 732 / 7090-3120
Fax +43 / 732 / 7090-6301
E-Mail: kus@keba.com
www.keba.com


