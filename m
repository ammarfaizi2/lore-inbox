Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266181AbUJATDd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266181AbUJATDd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 15:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266173AbUJATDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 15:03:33 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:42130 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266163AbUJATDT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 15:03:19 -0400
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM LTC (xSeries Solutions
To: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: [Patch 1/2] Disable SW irqbalance/irqaffinity for E7520/E7320/E7525 - change TARGET_CPUS on x86_64
Date: Fri, 1 Oct 2004 12:02:40 -0700
User-Agent: KMail/1.5.4
Cc: Suresh Siddha <suresh.b.siddha@intel.com>, linux-kernel@vger.kernel.org,
       tom.l.nguyen@intel.com
References: <2HSdY-7dr-3@gated-at.bofh.it> <20040930230133.0d4bcc0d.akpm@osdl.org> <20041001071922.GA32950@muc.de>
In-Reply-To: <20041001071922.GA32950@muc.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410011202.41048.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 October 2004 12:19 am, Andi Kleen wrote:
> On Thu, Sep 30, 2004 at 11:01:33PM -0700, Andrew Morton wrote:
> > Suresh Siddha <suresh.b.siddha@intel.com> wrote:
> > > Set TARGET_CPUS on x86_64 to cpu_online_map. This brings the code
> > > inline with x86 mach-default. Fix MSI_TARGET_CPU code which will
> > > break with this target_cpus change.
> >
> > This gets rejects all over the place against the x86_64 clustered
> > APIC mode patch.
> >
> > Which has priority here?
>
> Definitely the MSI_TARGET_CPUS thingy.
>
> The Clustered APIC patch is far off pie in the sky for some future
> unreleased hardware. MSI workaround fixes basic compilation
> and the original patch from Suresh fixes shipping Intel chipsets.
>
> -Andi

Excuse me, but since when is February "far off pie in the sky for some 
future unreleased hardware"?

Zeus boxes are going out the door 1Q2005.  The question is, will v2.6 
work on them or not?

-- 
James Cleverdon
IBM LTC (xSeries Linux Solutions)
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot comm

