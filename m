Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261895AbVC3Nvo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbVC3Nvo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 08:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbVC3Nvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 08:51:44 -0500
Received: from general.keba.co.at ([193.154.24.243]:41371 "EHLO
	helga.keba.co.at") by vger.kernel.org with ESMTP id S261895AbVC3Nvi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 08:51:38 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: 2.6.11, USB: High latency?
Date: Wed, 30 Mar 2005 15:51:33 +0200
Message-ID: <AAD6DA242BC63C488511C611BD51F3673231C5@MAILIT.keba.co.at>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.11, USB: High latency?
Thread-Index: AcU1L5XQyEe5UL1URE2EFwpTPmGahA==
From: "kus Kusche Klaus" <kus@keba.com>
To: <stern@rowland.harvard.edu>, <linux-usb-users@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm performing realtime latency tests (for details about the hardware
and software, see my mail "[BUG] 2.6.11: Random SCSI/USB errors when
reading from USB memory stick" erlier today).

Even when the errors described in my previous mail does not occur,
massive USB stick transfers cause latencies of 1 to 2 milliseconds,
which is way too much for realtime control systems. 

I observe these latencies on a vanilla 2.6.11 at any rtprio (even 99),
and on realtime-preempt-2.6.12-rc1-V0.7.41-11 at low rtprio (1). When
running the program on realtime-preempt-2.6.12-rc1-V0.7.41-11 with
rtprio 99, the latencies are gone, but using a rtprio higher than the
interrupt handlers is not realistic.

Is there anything which can be done about it?

Klaus Kusche
> Entwicklung Software - Steuerung
> Software Development - Control
> 
> KEBA AG
> A-4041 Linz
> Gewerbepark Urfahr
> Tel +43 / 732 / 7090-3120
> Fax +43 / 732 / 7090-8919
> E-Mail: kus@keba.com
> www.keba.com
> 
> 
