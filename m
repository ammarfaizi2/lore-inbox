Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161071AbWASHTv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161071AbWASHTv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 02:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161076AbWASHTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 02:19:51 -0500
Received: from general.keba.co.at ([193.154.24.243]:44669 "EHLO
	helga.keba.co.at") by vger.kernel.org with ESMTP id S1161071AbWASHTu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 02:19:50 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: My vote against eepro* removal
Date: Thu, 19 Jan 2006 08:19:37 +0100
Message-ID: <AAD6DA242BC63C488511C611BD51F367323320@MAILIT.keba.co.at>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: My vote against eepro* removal
Thread-Index: AcYcyLRs/hzvoSHvSD62aE+mDAYIYg==
From: "kus Kusche Klaus" <kus@keba.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Last time I tested (around 2.6.12), eepro100 worked much better 
in -rt kernels w.r.t. latencies than e100:

e100 caused a periodic latency of about 500 microseconds
exactly every 2 seconds, no matter what the load on the interface
was (i.e. even on an idle interface).

eepro100 did not show any latencies that long, it worked much
smoother w.r.t. latencies.

Of course I would prefer to have e100 fixed over keeping eepro100
around forever, but the last time I checked, it still wasn't fixed.

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


