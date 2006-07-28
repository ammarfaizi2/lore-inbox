Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161188AbWG1RUW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161188AbWG1RUW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 13:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161189AbWG1RUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 13:20:22 -0400
Received: from outbound-kan.frontbridge.com ([63.161.60.23]:50730 "EHLO
	outbound1-kan-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1161188AbWG1RUV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 13:20:21 -0400
X-BigFish: V
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [patch] Reorganize the cpufreq cpu hotplug locking to not
 be totally bizare
Date: Fri, 28 Jul 2006 12:09:00 -0500
Message-ID: <84EA05E2CA77634C82730353CBE3A84303218F26@SAUSEXMB1.amd.com>
In-Reply-To: <p73slkl4z41.fsf@verdi.suse.de>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch] Reorganize the cpufreq cpu hotplug locking to not
 be totally bizare
Thread-Index: AcayTOIcWg8XhSm2TLKupFxc24RkmgAG5UgA
From: "Langsdorf, Mark" <mark.langsdorf@amd.com>
To: ak@suse.de
cc: "linux-kernel" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 28 Jul 2006 17:09:02.0003 (UTC)
 FILETIME=[85EF4030:01C6B268]
X-WSS-ID: 68D49B270Y8699157-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > If there's a better way to hop to a specific core, I'll 
> gladly rewrite 
> > the code in question.
> 
> You could use smp_call_function_single() 
> 
> (i386 version might be only in -mm* so far)

I'll wait and submit for 2.6.20, I guess.

-Mark Langsdorf
AMD, Inc.


