Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263385AbTJUVzb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 17:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263387AbTJUVzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 17:55:31 -0400
Received: from [195.222.70.12] ([195.222.70.12]:56282 "EHLO mx01.belsonet.net")
	by vger.kernel.org with ESMTP id S263385AbTJUVz0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 17:55:26 -0400
Date: Wed, 22 Oct 2003 00:53:28 +0300
From: Alexander Bokovoy <ab@altlinux.org>
To: M?ns Rullg?rd <mru@kth.se>
Cc: cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET] 0/3 Dynamic cpufreq governor and updates to ACPI P-state driver
Message-ID: <20031021215327.GH3133@sam-solutions.net>
References: <88056F38E9E48644A0F562A38C64FB60077911@scsmsx403.sc.intel.com> <yw1xbrsaeu44.fsf@kth.se> <20031021203037.GB3133@sam-solutions.net> <yw1xoewaiavf.fsf@kth.se> <20031021211119.GE3133@sam-solutions.net> <yw1xfzhmi86r.fsf@kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <yw1xfzhmi86r.fsf@kth.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 21, 2003 at 11:37:16PM +0200, M?ns Rullg?rd wrote:
> Alexander Bokovoy <ab@altlinux.org> writes:
> 
> >> What's your /proc/cpuinfo?  Mine says
> >> 
> >> processor	: 0
> >> vendor_id	: GenuineIntel
> >> cpu family	: 15
> >> model	: 2
> >> model name	: Mobile Intel(R) Pentium(R) 4 - M CPU 1.80GHz
> >> stepping	: 7
> 
> > As I said, it is Centrino-based, with 1.3GHz Pentium M:
> >
> > processor	: 0
> > vendor_id	: GenuineIntel
> > cpu family	: 6
> > model		: 9
> > model name	: Intel(R) Pentium(R) M processor 1300MHz
> > stepping	: 5
> 
> So, mine won't work, or what?
If you can boot into 2.4.22 or .23pre with ACPI enabled and can see
/proc/acpi/processor/CPU0/performance, then your processor should be
supported by speedstep-ich or speedstep-piix4 modules (don't know which
one exactly).
-- 
/ Alexander Bokovoy
Samba Team                      http://www.samba.org/
ALT Linux Team                  http://www.altlinux.org/
Midgard Project Ry              http://www.midgard-project.org/
