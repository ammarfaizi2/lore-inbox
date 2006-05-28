Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbWE1QX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbWE1QX7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 12:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbWE1QX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 12:23:59 -0400
Received: from smtp2.poczta.interia.pl ([213.25.80.232]:61979 "EHLO
	smtp.poczta.interia.pl") by vger.kernel.org with ESMTP
	id S1750789AbWE1QX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 12:23:58 -0400
Message-ID: <4479CE8F.2000608@interia.pl>
Date: Sun, 28 May 2006 18:23:43 +0200
From: =?ISO-8859-2?Q?Rafa=B3_Bilski?= <rafalbilski@interia.pl>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ PATCH ] Longhaul - call suspend(PMSG_FREEZE) before and	resume()
 after
References: <44798B99.9070608@interia.pl> <20060528145639.GA2984@redhat.com>
In-Reply-To: <20060528145639.GA2984@redhat.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
X-EMID: 3fabcacc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Nehemiah has a local APIC, and is SMP capable.
> (Though boards are hard to come by, and longhaul.ko has never
>  been tested on such a system)
> 
> 		Dave

We both have right. My C3 is in EBGA and datasheet (v1.90) for 
EBGA C3 says:
> OMITTED FUNCTIONS
> 
> Symmetric Multiprocessing Support: APIC
> This bus function is omitted since the target market for the VIA C3 
> in EBGA is portables and typical desktop systems (which do not 
> support APIC multiprocessing). A bit in the feature identification 
> returned from the CPUID instruction indicates whether this feature 
> is present or not. This enhancement is not provided on the VIA C3 in EBGA.

But C3 in FCPGA(?) have APIC support.

Rafal


----------------------------------------------------------------------
INTERIA.PL dla kobiet... >>> http://link.interia.pl/f193b

