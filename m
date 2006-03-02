Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751682AbWCBTjX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751682AbWCBTjX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 14:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752051AbWCBTjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 14:39:23 -0500
Received: from fmr17.intel.com ([134.134.136.16]:50573 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751679AbWCBTjW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 14:39:22 -0500
x-mimeole: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: 2.6.16rc5 'found' an extra CPU.
Date: Thu, 2 Mar 2006 14:37:09 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30063F908B@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.16rc5 'found' an extra CPU.
Thread-Index: AcY+MGkRoyXUradQS/yd1kOgIPxv8AAACT4w
From: "Brown, Len" <len.brown@intel.com>
To: "Dave Jones" <davej@redhat.com>
Cc: "Chuck Ebbert" <76306.1226@compuserve.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "linux-acpi" <linux-acpi@vger.kernel.org>, "Andi Kleen" <ak@suse.de>
X-OriginalArrivalTime: 02 Mar 2006 19:37:11.0821 (UTC) FILETIME=[B38AD3D0:01C63E30]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>On Thu, Mar 02, 2006 at 02:26:24PM -0500, Brown, Len wrote:
> > Dave,
> > Your DSDT looks fine.
> > I was wrong assuming there were 3 Processor entries there.
> > 
> > > > Did you really build a 256-CPU SMP kernel or is ACPI 
> > > > ignoring CONFIG_NR_CPUS or something?
> > >
> > >Yes, it's =256.
> > 
> > I expect this is the root problem.
>
>If this is the _cause_, something needs fixing, but it's hardly
>something we can brush off as 'the root problem'.
>
>It's entirely possible for such a configuration (higher
>CONFIG_NR_CPUS than actual cpus), cf. distro kernels.

I agree.
Did Ashok's sigined-unsigned patch work?
