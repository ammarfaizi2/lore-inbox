Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbTITA5p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 20:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbTITA5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 20:57:45 -0400
Received: from fmr09.intel.com ([192.52.57.35]:52990 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S261438AbTITA5o convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 20:57:44 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [PATCH 2.6.x] additional kernel event notifications
Date: Fri, 19 Sep 2003 17:57:40 -0700
Message-ID: <7F740D512C7C1046AB53446D372001732DEC73@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.x] additional kernel event notifications
Thread-Index: AcN+95sgd7RZ/hawR0ikwvSBJkFHZAADdO2w
From: "Villacis, Juan" <juan.villacis@intel.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <jbarnes@sgi.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 20 Sep 2003 00:57:41.0169 (UTC) FILETIME=[316A3A10:01C37F12]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

"Andrew Morton" <akpm@osdl.org> wrote:
> Have you considered interfacing vtune userspace
> to oprofilefs and enhancing oprofilefs to meet
> vtune requirements, thus removing the need for
> the vtune kernel module, and its device node 
> and ioctl interface?

We have considered the option of using Oprofile's mechanisms for VTune,
but Oprofile and VTune do different things in different ways.  For
example,
both tools capture performance data, but Oprofile was designed with
aggregation in mind whereas VTune was designed to collect all the data
and then post-process it.

We are open to putting the VTune driver into the kernel source tree.
However, is consolidation of the performance tools a requirement for 
getting the four additional event notifications into the kernel?

-juan
