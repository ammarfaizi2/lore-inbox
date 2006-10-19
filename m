Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946578AbWJSWPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946578AbWJSWPY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 18:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946577AbWJSWPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 18:15:24 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:64935 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1946574AbWJSWPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 18:15:22 -0400
Subject: Re: SMP broken on pre-ACPI machine.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@redhat.com>
Cc: Len Brown <lenb@kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org
In-Reply-To: <20061019201116.GG26530@redhat.com>
References: <20061018222433.GA4770@redhat.com>
	 <200610190133.40581.len.brown@intel.com>
	 <20061019191644.GE26530@redhat.com>  <20061019201116.GG26530@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 19 Oct 2006 23:17:19 +0100
Message-Id: <1161296239.17335.151.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-10-19 am 16:11 -0400, ysgrifennodd Dave Jones:
> On Thu, Oct 19, 2006 at 03:16:44PM -0400, Dave Jones wrote:
> 
>  > Why smp_found_config isn't set in that guys configuration is a mystery to me,
>  > as his MPS tables look sane..
>  > 
>  > MP Table:
>  > #	APIC ID	Version	State		Family	Model	Step	Flags
>  > #	 0	 0x10	 BSP, usable	 6	 2	 1	 0x0381

Isn't that an "overdrive" ? if so it isn't supposed to be SMP capable

