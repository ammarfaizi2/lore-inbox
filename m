Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161160AbWJKRgH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161160AbWJKRgH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 13:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161155AbWJKRgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 13:36:07 -0400
Received: from outbound-fra.frontbridge.com ([62.209.45.174]:43448 "EHLO
	outbound1-fra-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1161162AbWJKRgE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 13:36:04 -0400
X-BigFish: VP
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: cpufreq not working on AMD K8 (was Re: 2.6.19-rc1: known
 regressions)
Date: Wed, 11 Oct 2006 12:33:39 -0500
Message-ID: <1449F58C868D8D4E9C72945771150BDF1536FD@SAUSEXMB1.amd.com>
In-Reply-To: <200610111606.13180.christiand59@web.de>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: cpufreq not working on AMD K8 (was Re: 2.6.19-rc1: known
 regressions)
Thread-Index: AcbtPsEromMjWDkAT+qERX8PV++jLwAHFAUg
From: "Langsdorf, Mark" <mark.langsdorf@amd.com>
To: "Christian" <christiand59@web.de>
cc: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 11 Oct 2006 17:33:40.0308 (UTC)
 FILETIME=[640DF140:01C6ED5B]
X-WSS-ID: 6933F57E1L85618687-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It seems that my first try exceeded the LKML size limit. So 
> hopefully you should get my decompiled DSDT now as a bzip
> compressed file.

Right then.  You're completely missing the _PCT, _PPC, and
_PSS packages, as well as the CPU scope they're normally
defined in.  powernow-k8 is not going to work on this system.

If you boot with the 2.6.18 kernel, do you get the same
decompiled DSDT?  If not, there's an ACPI regression you
need to report to Len Brown.

Have you upgraded the processors or BIOS on the box?

-Mark Langsdorf
AMD, Inc.


