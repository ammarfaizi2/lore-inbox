Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932517AbWCBT1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932517AbWCBT1V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 14:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932500AbWCBT1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 14:27:21 -0500
Received: from fmr17.intel.com ([134.134.136.16]:32137 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S932494AbWCBT1U convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 14:27:20 -0500
x-mimeole: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: 2.6.16rc5 'found' an extra CPU.
Date: Thu, 2 Mar 2006 14:26:24 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30063F9031@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.16rc5 'found' an extra CPU.
Thread-Index: AcY9lmM4LevDqc3qTJqF0MPJrS+9xwAlWaXQ
From: "Brown, Len" <len.brown@intel.com>
To: "Dave Jones" <davej@redhat.com>,
       "Chuck Ebbert" <76306.1226@compuserve.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>,
       "linux-acpi" <linux-acpi@vger.kernel.org>, "Andi Kleen" <ak@suse.de>
X-OriginalArrivalTime: 02 Mar 2006 19:26:26.0598 (UTC) FILETIME=[32F59C60:01C63E2F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave,
Your DSDT looks fine.
I was wrong assuming there were 3 Processor entries there.

> > Did you really build a 256-CPU SMP kernel or is ACPI 
> > ignoring CONFIG_NR_CPUS or something?
>
>Yes, it's =256.

I expect this is the root problem.

-Len


