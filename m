Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751705AbWHAR03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751705AbWHAR03 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 13:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751696AbWHAR0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 13:26:07 -0400
Received: from ns2.suse.de ([195.135.220.15]:49079 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751699AbWHAR0E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 13:26:04 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] Re: [PATCH for 2.6.18] [2/8] x86_64: On Intel systems when CPU has C3 don't use TSC
Date: Tue, 1 Aug 2006 19:10:25 +0200
User-Agent: KMail/1.9.3
Cc: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
References: <44cbba2d.ejpOKfo7QfGElmoT%ak@suse.de> <1154437483.3264.14.camel@localhost.localdomain>
In-Reply-To: <1154437483.3264.14.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608011910.25110.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I had some faith in this patch , but this just enable boot parameter
> notsc (which I already use). And "just" disable tsc don't solve all the
> problems.

What problems do you have?

> 
> 
> After "Using ACPI (MADT) for SMP configuration information"
> my acpi_fadt.length is great than  0
> acpi_fadt.plvl3_lat is 1001

You don't have C3 support so the patch doesn't apply to you.

> On BIOS 1.40 update description of ASRock, claims this VIA chipset have
> C1 stepping support.

C1 stepping is a processor revision; it has nothing to do with
ACPI C* power states.

-Andi
