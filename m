Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261420AbUJ3XY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261420AbUJ3XY1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 19:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261436AbUJ3XWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 19:22:22 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:15012 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261377AbUJ3XPu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 19:15:50 -0400
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM LTC (xSeries Solutions
To: Andi Kleen <ak@suse.de>
Subject: Re: [Patch] x86-64: fix sibling map again!
Date: Sat, 30 Oct 2004 16:15:23 -0700
User-Agent: KMail/1.5.4
Cc: Suresh Siddha <suresh.b.siddha@intel.com>, ak@suse.de, akpm@osdl.org,
       linux-kernel@vger.kernel.org
References: <20041029170215.A26372@unix-os.sc.intel.com> <200410291735.32175.jamesclv@us.ibm.com> <20041030125604.GF14735@wotan.suse.de>
In-Reply-To: <20041030125604.GF14735@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410301615.23066.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I suppose not.  It seems a bit unnecessary, but OK if it makes
them happy.  Maybe Intel has something in mind for 2008.


On Saturday 30 October 2004 05:56 am, Andi Kleen wrote:
> On Fri, Oct 29, 2004 at 05:35:32PM -0700, James Cleverdon wrote:
> > Hey Suresh,
> >
> > Can you tell me why Intel considers cpuid to be The One True
> > Way(TM) to get sibling info?  Especially on x86-64, which
> > doesn't have the same level of APIC weirdness that i386 does.
> >
> > (I won't even mention the fact that someone messed up on the
> > MSR the BIOS can use to set bits 7:5 in the cpuid ID value.
> > It should allow the BIOS to set bits 7:3.)
>
> I have no great opinion on either ways, but I suppose
> it is best to do the same thing as i386 and apply Suresh's patch.
>
> James, any strong objections?
>
> -Andi

-- 
James Cleverdon
IBM LTC (xSeries Linux Solutions)
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot comm

