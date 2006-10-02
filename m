Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964921AbWJBTuy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964921AbWJBTuy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 15:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964927AbWJBTux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 15:50:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:36530 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964921AbWJBTux (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 15:50:53 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] Re: Please report all left over "DWARF2 unwinder stucks"
Date: Mon, 2 Oct 2006 21:50:48 +0200
User-Agent: KMail/1.9.3
Cc: Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org
References: <200610012201.20544.ak@suse.de> <adazmcev8qy.fsf@cisco.com>
In-Reply-To: <adazmcev8qy.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610022150.48346.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> [  971.940288] Call Trace:
> [  971.952076]  [<ffffffff8026018f>] show_trace+0x34/0x47
> [  971.967433]  [<ffffffff802601b4>] dump_stack+0x12/0x17
> [  971.982793]  [<ffffffff80294a10>] softlockup_tick+0xdb/0xed
> [  971.999517]  [<ffffffff8027e49e>] update_process_times+0x42/0x68
> [  972.017521]  [<ffffffff802677d0>] smp_local_timer_interrupt+0x23/0x47
> [  972.036770]  [<ffffffff80267c7a>] smp_apic_timer_interrupt+0x38/0x3e
> [  972.055761]  [<ffffffff80254ce6>] apic_timer_interrupt+0x66/0x70
> [  972.073697] DWARF2 unwinder stuck at apic_timer_interrupt+0x66/0x70

Thanks. Fixed that one.

-Andi
