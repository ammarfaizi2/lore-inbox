Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbWATShp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbWATShp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 13:37:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbWATShp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 13:37:45 -0500
Received: from palrel11.hp.com ([156.153.255.246]:40393 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S1751140AbWATSho convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 13:37:44 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [perfmon] Re: quick overview of the perfmon2 interface
Date: Fri, 20 Jan 2006 10:37:42 -0800
Message-ID: <3C87FFF91369A242B9C9147F8BD0908A02C6955C@cacexc04.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [perfmon] Re: quick overview of the perfmon2 interface
thread-index: AcYd23vlDpF1+LsPTEiURN5p7jXBcwADERYQ
From: "Truong, Dan" <dan.truong@hp.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: "Eranian, Stephane" <stephane.eranian@hp.com>, <perfmon@napali.hpl.hp.com>,
       <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <perfctr-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 20 Jan 2006 18:37:43.0406 (UTC) FILETIME=[99AA28E0:01C61DF0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Would you want Stephane to guard the extended
functionalities with tunables or something to
Disable their regular use and herd enterprise
Tools into a standard mold... yet allow R&D to
Move on by enabling the extentions?



Just crippling flexibility/cutting functionality
is like removing words out of a dictionary to
prevent people from thinking different.

It would restrict the R&D mindset, and new ideas.
The field hasn't grown yet to a stable mature form.
It is just beginning: profiling, monitoring, tuning,
compilers, JIT...

Flexibility is/was needed because:
- Tools need to port to Perfmon with min cost.
- Ability to support novel R&D ideas.
- Ability to support growth beyond just PMU data
- Allows early data aggregation
- Allow OS data correlated to PMU

What standardization adds:
- Coordinated access to PMU rssources from all tools
- All tools/formats etc all plug into the same OS framework.
- The interface gets ported across multiple platforms.
- The functionality is rich for all (fast data transfers,
  multiplexing, system vs thead, etc.)

Dan-

> -----Original Message-----
> From: perfmon-bounces@napali.hpl.hp.com [mailto:perfmon-
> bounces@napali.hpl.hp.com] On Behalf Of Andrew Morton
> Sent: Thursday, December 22, 2005 5:47 AM
> To: Truong, Dan
> Cc: Eranian, Stephane; perfmon@napali.hpl.hp.com; linux-
> ia64@vger.kernel.org; linux-kernel@vger.kernel.org; perfctr-
> devel@lists.sourceforge.net
> Subject: Re: [perfmon] Re: quick overview of the perfmon2 interface
> 
> "Truong, Dan" <dan.truong@hp.com> wrote:
> >
> > The PMU is becoming a standard commodity. Once Perfmon is
> > "the" Linux interface, all the tools can align on it and
> > coexist, push their R&D forward, and more importantly become
> > fully productized for businesses usage.
> >
> 
> The apparently-extreme flexibility of the perfmon interfaces would
tend to
> militate against that, actually.  It'd become better productised if it
had
> one interface and stuck to it.
> 
> (I haven't processed Stephane's reply yet - will get there)
> 
> _______________________________________________
> perfmon mailing list
> perfmon@linux.hpl.hp.com
> http://www.hpl.hp.com/hosted/linux/mail-archives/perfmon/
