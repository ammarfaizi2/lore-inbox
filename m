Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932078AbWEBUVt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbWEBUVt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 16:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbWEBUVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 16:21:49 -0400
Received: from smtp-out.google.com ([216.239.45.12]:29504 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932078AbWEBUVs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 16:21:48 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=x6CRtAMMk+6cVB1QMDXBKkqGijOf23ioT4Tm3MsEkICqz2T3IdezMo7bQBZOPEoX9
	r0KxkQ1WeQXsxF91NVO6g==
Message-ID: <4457BF23.5010700@google.com>
Date: Tue, 02 May 2006 13:20:51 -0700
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Bligh <mbligh@google.com>
CC: Andrew Morton <akpm@osdl.org>, apw@shadowen.org,
       linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: 2.6.17-rc2-mm1
References: <4450F5AD.9030200@google.com>	<20060428012022.7b73c77b.akpm@osdl.org>	<44561A1E.7000103@google.com> <20060501100731.051f4eff.akpm@osdl.org> <44564613.7070702@google.com>
In-Reply-To: <44564613.7070702@google.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Andy, any chance you could do another run on elm3b6 of ltp with:
> 2.6.17-rc3 + http://test.kernel.org/patches/2.6.17-rc3-mm1-64
> 
> Which is:
> 
> x86_64-add-compat_sys_vmsplice-and-use-it-in.patch
> i386-x86-64-fix-acpi-disabled-lapic-handling.patch
> x86_64-mm-defconfig-update.patch
> x86_64-mm-phys-apicid.patch
> x86_64-mm-memset-always-inline.patch
> x86_64-mm-amd-core-cpuid.patch
> x86_64-mm-amd-cpuid4.patch
> x86_64-mm-alternatives.patch
> x86_64-mm-pci-dma-cleanup.patch
> x86_64-mm-ia32-unistd-cleanup.patch
> x86_64-mm-large-bzimage.patch
> x86_64-mm-topology-comment.patch
> x86_64-mm-agp-select.patch
> x86_64-mm-iommu_gart_bitmap-search-to-cross-next_bit.patch
> x86_64-mm-new-compat-ptrace.patch
> x86_64-mm-disable-agp-resource-check.patch
> x86_64-mm-avoid-irq0-ioapic-pin-collision.patch
> x86_64-mm-gart-direct-call.patch
> x86_64-mm-new-northbridge.patch
> x86_64-mm-iommu-warning.patch
> x86_64-mm-serialize-assign_irq_vector-use-of-static-variables.patch
> x86_64-mm-simplify-ioapic_register_intr.patch
> x86_64-mm-i386-apic-overwrite.patch
> x86_64-mm-i386-up-generic-arch.patch
> x86_64-mm-iommu-enodev.patch
> x86_64-mm-fix-die_lock-nesting.patch
> x86_64-mm-add-nmi_exit-to-die_nmi.patch
> x86_64-mm-compat-printk.patch
> x86_64-mm-hotadd-reserve-fix-fix-fix.patch
> x86_64-mm-compat-printk-fix.patch
> x86_64-mm-new-northbridge-fix.patch
> x86-64-calgary-iommu-introduce-iommu_detected.patch
> x86-64-calgary-iommu-calgary-specific-bits.patch
> x86-64-calgary-iommu-hook-it-in.patch
> x86-64-check-for-valid-dma-data-direction-in-the-dma-api.patch

It worked fine with this lot. Hmmm. I guess that makes sense, if it's
the same issue that intermittently occurs on ppc64 (and perhaps it's
easier to diagnose there, since we get better stack tracing).

M.

