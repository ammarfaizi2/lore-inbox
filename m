Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751472AbWCBPtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbWCBPtQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 10:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751490AbWCBPtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 10:49:16 -0500
Received: from fsmlabs.com ([168.103.115.128]:1163 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S1751472AbWCBPtP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 10:49:15 -0500
X-ASG-Debug-ID: 1141314552-28564-158-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Thu, 2 Mar 2006 07:53:39 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Romano Giannetti <romanol@upcomillas.es>
cc: "Brown, Len" <len.brown@intel.com>, Dave Jones <davej@redhat.com>,
       "Raj, Ashok" <ashok.raj@intel.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
X-ASG-Orig-Subj: Re: 2.6.16rc5 'found' an extra CPU.
Subject: Re: 2.6.16rc5 'found' an extra CPU.
In-Reply-To: <20060302093333.GB18448@pern.dea.icai.upcomillas.es>
Message-ID: <Pine.LNX.4.64.0603020737420.28074@montezuma.fsmlabs.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B30063BFB95@hdsmsx401.amr.corp.intel.com>
 <20060302093333.GB18448@pern.dea.icai.upcomillas.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.9345
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Mar 2006, Romano Giannetti wrote:

> On Thu, Mar 02, 2006 at 12:49:53AM -0500, Brown, Len wrote:
> > 
> > I'm afraid that even after we get this stuff out of /proc
> > and into sysfs where it belongs, we'll have to leave /proc/acpi around
> > for a while b/c unfortunately people are under the impression
> > that the path names there actually mean something and
> > they can actually count on them -- which they can't.
> 
> Is it possible to obtain the same control/information with sysfs that is
> available from /proc/acpi? For example, I use quite extensively CPU
> throttling on my VAIO ("cool & quiet home-made mode"), and I was unable to
> find the equivalent of /proc/acpi/processor/CPU0/throttling ...

I can't help thinking that that should be going through cpufreq.
