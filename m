Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263343AbTK1SSY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 13:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263345AbTK1SSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 13:18:24 -0500
Received: from mail.gmx.net ([213.165.64.20]:7613 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263343AbTK1SSU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 13:18:20 -0500
X-Authenticated: #4512188
Message-ID: <3FC79168.60909@gmx.de>
Date: Fri, 28 Nov 2003 19:18:16 +0100
From: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031116
X-Accept-Language: de-de, de, en-us, en
MIME-Version: 1.0
To: Julien Oster <lkml-7439@mc.frodoid.org>
CC: ross.alexander@uk.neceur.com, Brendan Howes <brendan@netzentry.com>,
       linux-kernel@vger.kernel.org
Subject: Re: NForce2 pseudoscience stability testing (2.6.0-test11)
References: <OF6617181D.A93B9D63-ON80256DEC.004D7534-80256DEC.0053A823@uk.neceur.com> <frodoid.frodo.874qwo9xwc.fsf@usenet.frodoid.org>
In-Reply-To: <frodoid.frodo.874qwo9xwc.fsf@usenet.frodoid.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Julien Oster wrote:
> ross.alexander@uk.neceur.com writes:
>>I have been test various kernel parameter combinations to test stability.
> 
> 
> Thanks, that's quite a nice overview.
> 
> But something seems strange:
> 
> 
>>APIC,LAPIC                                              S
>>PREM,APIC,LAPIC                                         S
> 
> 
> Does those two lines mean, that using ACPI, APIC and local APIC
> enabled is stable, as long as your kernel is not an SMP kernel? If
> yes, then I can't confirm this. I run strictly non-SMP kernels and
> they always crash if APIC (or local APIC?) is enabled.

I also have the same problem on an Abit NF7-S V2.0: I think I tested 
(non-SMP always) with kernel 2.6-test8 last: With Apic (and/or local 
apic) system locks up. Without it is now rock-solid with ACPI. But it 
seems to be a BIOS issue, as Windows locks up with APIC use, as well. 
Well I am using latest BIOS and hope that Abit gets this fixed...

BTW, why would someone want an SMP kernel for a 1-CPU system?

Prakash

