Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbUCKSrW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 13:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbUCKSrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 13:47:22 -0500
Received: from fmr06.intel.com ([134.134.136.7]:39887 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S261652AbUCKSrP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 13:47:15 -0500
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: 2.6.4-mm1
Date: Thu, 11 Mar 2004 10:46:59 -0800
Message-ID: <7F740D512C7C1046AB53446D37200173FEB76A@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.4-mm1
Thread-Index: AcQHPCECv5YUhMeNQjCyf4RmLlSEWwAW00iw
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 11 Mar 2004 18:47:00.0737 (UTC) FILETIME=[3CF61F10:01C40799]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, we have been testing the sched-domain scheduler. So far, the
results are all positive. We'll add more stress to it, running various
workloads.

Jun
>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
>owner@vger.kernel.org] On Behalf Of Andrew Morton
>Sent: Wednesday, March 10, 2004 11:32 PM
>To: linux-kernel@vger.kernel.org
>Subject: 2.6.4-mm1
>
>
>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.4/2.6
.4-
>mm1/
>
>
>
>- The CPU scheduler changes in -mm (sched-domains) have been hanging
about
>  for too long.  I had been hoping that the people who care about SMT
and
>  NUMA performance would have some results by now but all seems to be
>silent.
>
>  I do not wish to merge these up until the big-iron guys can say that
they
>  suit their requirements, with a reasonable expectation that we will
not
>  need to churn this code later in the 2.6 series.
>
>  So.  If you have been testing, please speak up.  If you have not been
>  testing, please do so.
>

