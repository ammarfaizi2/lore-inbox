Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932194AbWF0MXX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbWF0MXX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 08:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbWF0MXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 08:23:23 -0400
Received: from fwstl1-1.wul.qc.ec.gc.ca ([205.211.132.24]:15049 "EHLO
	ecstlaurent8.quebec.int.ec.gc.ca") by vger.kernel.org with ESMTP
	id S932194AbWF0MXW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 08:23:22 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
Subject: RE: SATA hangs...
Date: Tue, 27 Jun 2006 08:23:19 -0400
Message-ID: <8E8F647D7835334B985D069AE964A4F7028FDCC5@ECQCMTLMAIL1.quebec.int.ec.gc.ca>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: SATA hangs...
Thread-Index: AcaX3flw7wKqNSYBQaWJF1obI0VqgQCBgbFA
From: "Fortier,Vincent [Montreal]" <Vincent.Fortier1@EC.GC.CA>
To: "Hamish" <hamish@travellingkiwi.com>,
       "Paolo Ornati" <ornati@fastwebnet.it>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 27 Jun 2006 12:23:20.0382 (UTC) FILETIME=[79ED35E0:01C699E4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> I'll try a re-compile of 2.7.17.1 vanilla with no pre-empt & 
> see how it goes.
> 

Simply give a try at disabling irqbalance service... This solved all of
my problems (jerky mouse, lan dropping, etc..) with the exception of
ATAPI over SATA which actually got fixed in 2.6.17.

Hope this helps!

- vin
