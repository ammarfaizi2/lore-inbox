Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbWHVKpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbWHVKpJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 06:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932161AbWHVKpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 06:45:09 -0400
Received: from madara.hpl.hp.com ([192.6.19.124]:34756 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S932162AbWHVKpH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 06:45:07 -0400
Date: Tue, 22 Aug 2006 03:34:58 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86-64 add missing PMU MSR definitions
Message-ID: <20060822103458.GB30053@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <20060820214856.GD27542@frankl.hpl.hp.com> <200608210113.44984.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608210113.44984.ak@suse.de>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@frankl.hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

On Mon, Aug 21, 2006 at 01:13:44AM +0200, Andi Kleen wrote:
> On Sunday 20 August 2006 23:48, Stephane Eranian wrote:
> > Hello,
> > 
> > Here is a patch to add a couple of missing MSR definitions related
> > to Performance monitoring for EM64T. A separate patch contains the
> > i386 equivalent.
> > 
> > Changelog:
> >         - add MSR definitions for IA32_PEBS_ENABLE and PEBS_MATRIX_VERT
> 
> 
> The names seem somewhat mixed up.
> 
> I think I would prefer P4 and no IA32 prefixes for all of them.
> (or does Core2 still have PEBS?)

OK, let's wait until Intel *finally* releases the Core 2 PMU specification
publicly and then I'll push a patch. Those MSRs are not that critical anyway.
Perfmon2 is probably the only consumer.

-- 
-Stephane
