Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275431AbTHIWRR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 18:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275432AbTHIWRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 18:17:17 -0400
Received: from ms-smtp-03.rdc-kc.rr.com ([24.94.166.129]:49110 "EHLO
	ms-smtp-03.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S275431AbTHIWRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 18:17:12 -0400
Date: Sat, 9 Aug 2003 17:17:06 -0500
From: Greg Norris <haphazard@kc.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-test3] Hyperthreading gone
Message-ID: <20030809221706.GA2106@glitch.localdomain>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <87llu2bvxg.fsf@deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87llu2bvxg.fsf@deneb.enyo.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Did you select CPU Enumeration Only, or "normal" ACPI?  If the former,
did you specify the "acpismp=force" parameter at bootup?

On Sat, Aug 09, 2003 at 07:08:43PM +0200, Florian Weimer wrote:
> ACPI with CPU enumeration is enabled, but the sibling CPUs aren't
> activated.
> 
> This is all what I have of the boot message (standard buffer size is
> too small, apparently):
> 
> CPU:     After all inits, caps: 3febfbff 00000000 00000000 00000080
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#3.
> CPU#3: Intel P4/Xeon Extended MCE MSRs (12) available
> CPU#3: Thermal monitoring enabled
> CPU3: Intel(R) Xeon(TM) CPU 1.40GHz stepping 01
> Total of 4 processors activated (11034.62 BogoMIPS).
> WARNING: No sibling found for CPU 0.
> WARNING: No sibling found for CPU 1.
> WARNING: No sibling found for CPU 2.
> WARNING: No sibling found for CPU 3.
> 
> Recent 2.4.x kernels (starting with 2.4.20 IIRC) support
> Hyperthreading on this machine (Siemens Primergy H450).
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
