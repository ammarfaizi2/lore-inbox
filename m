Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbVKOAKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbVKOAKK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 19:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbVKOAKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 19:10:10 -0500
Received: from tayrelbas01.tay.hp.com ([161.114.80.244]:19632 "EHLO
	tayrelbas01.tay.hp.com") by vger.kernel.org with ESMTP
	id S932181AbVKOAKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 19:10:08 -0500
Date: Mon, 14 Nov 2005 16:09:48 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: Paul Mackerras <paulus@samba.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, ak@muc.de,
       benh@kernel.crashing.org, stephane.eranian@hp.com, tony.luck@intel.com
Subject: Re: + perfmon2-reserve-system-calls.patch added to -mm tree
Message-ID: <20051115000948.GC23839@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <200511142329.jAENTfmS004600@shell0.pdx.osdl.net> <200511150050.27556.arnd@arndb.de> <17273.9731.963322.721596@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17273.9731.963322.721596@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul,

On Tue, Nov 15, 2005 at 11:04:19AM +1100, Paul Mackerras wrote:
> Arnd Bergmann writes:
> 
> > Hmm, I had sent an earlier patch to paulus that reserves 278 and
> > 279 for spu_run and spu_create and that apparently got dropped.
> 
> Hmmm, sorry, I thought I had put that in, but evidently not.
> 
> > Could I have those two numbers or is there already an established
> > user based for the perfmon2 numbers that would take preference?
> 
> I don't believe there is any user base of the perfmon2 numbers.
> Stephane, could you respin using 280 - 291 for PowerPC?
> 
Yes, at this point I am just reserving the syscall numbers, nothing is
hardcoded into any application, so we can certainly change it. I'll do
that and resubmit the powerpc portion. From Andrew, I understand I have
to do this in arch/powerpc and also in arch/ppc.

-- 
-Stephane
