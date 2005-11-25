Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751427AbVKYK11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbVKYK11 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 05:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbVKYK10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 05:27:26 -0500
Received: from eurocopter-av-smtp1.gmessaging.net ([194.51.201.42]:25588 "EHLO
	eurocopter-av-smtp1.gmessaging.net") by vger.kernel.org with ESMTP
	id S1751427AbVKYK10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 05:27:26 -0500
Date: Fri, 25 Nov 2005 11:26:19 +0100
From: "Schultheiss, Christoph" <Christoph.Schultheiss@eurocopter.com>
Subject: duration of udelay differs with activated realtime-preempt patch?
To: linux-kernel@vger.kernel.org
Message-id: <B7DA45CF87D412408436D5ECAAB9B90F6E7A06@sma2906.cr.eurocopter.corp>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-class: urn:content-classes:message
Thread-topic: duration of udelay differs with activated realtime-preempt patch?
Thread-index: AcXxqqz1TfzKAUS9S++geYkGQ06R2g==
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
X-OriginalArrivalTime: 25 Nov 2005 10:26:19.0705 (UTC)
 FILETIME=[ACE06A90:01C5F1AA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel: 2.6.14 with and without the realtime-preempt patch

hi list,

after measuring the duration of the function udelay (with oscilloscope
at parallel port), I figured out that udelay (5usec) with activated
realtime- preempt patch lasts a little bit longer. Without the patch the
time is exact.
All kernel debug switches are turned off at compile time.
Can anyone suggest why this happens?

christoph
