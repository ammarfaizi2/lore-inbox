Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263015AbTIVGXS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 02:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263017AbTIVGXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 02:23:18 -0400
Received: from fmr09.intel.com ([192.52.57.35]:30678 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S263015AbTIVGXR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 02:23:17 -0400
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 2.6.x] additional kernel event notifications
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Date: Sun, 21 Sep 2003 23:23:11 -0700
Message-ID: <7F740D512C7C1046AB53446D372001732DEC85@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.x] additional kernel event notifications
Thread-Index: AcN/nJ+rHa/9bFDeTzS+XSEHnxHz/wBNOomg
From: "Villacis, Juan" <juan.villacis@intel.com>
To: "Anton Blanchard" <anton@samba.org>
Cc: "Andrew Morton" <akpm@osdl.org>, <jbarnes@sgi.com>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 22 Sep 2003 06:23:11.0827 (UTC) FILETIME=[FF6BA230:01C380D1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

"Anton Blanchard" <anton@samba.org> writes:
> Could you please explain why you cant build on top of oprofile? If
arch
> specific profilers start going in, we are going to have 5 different
ways
> of doing the same thing.

The patch we submitted adds 4 generic hooks to the existing set of
profiling hooks.  These additional hooks can be used to help performance
tools such as Oprofile and VTune to not mis-attribute performance data.

> We really need to work together on this. We for example have a bunch
of
> ppc64 profiling stuff but throwing that into the kernel to create yet
> another profiler is not the answer.

We are open to the possibility of including the VTune driver into the
base kernel, perhaps in an architecture-dependent area.  It could
complement existing profilers.

-juan

