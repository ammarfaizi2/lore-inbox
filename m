Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422643AbWIEVGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422643AbWIEVGf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 17:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422642AbWIEVGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 17:06:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:26844 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1422643AbWIEVGe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 17:06:34 -0400
To: "Om Narasimhan" <om.turyx@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: howto map HDT dumped addresses to AMD64 kernel virtual addresses.
References: <6b4e42d10609051048o23b8c5edj2ab110bd87acd57f@mail.gmail.com>
From: Andi Kleen <ak@suse.de>
Date: 05 Sep 2006 23:06:32 +0200
In-Reply-To: <6b4e42d10609051048o23b8c5edj2ab110bd87acd57f@mail.gmail.com>
Message-ID: <p734pvm58h3.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Om Narasimhan" <om.turyx@gmail.com> writes:

> Hi,
> I am running a kernel (Suse Enterprise 9 with SP3) and it is hanging
> somewhere in the kernel. By hooking up HDT from AMD, I got a the
> assembly dump of the routine which causes the infinite loop. How
> should I map the addresses dumped by HDT in the format SEG:Offset
> (e.g,
> 0033:00000000_00400C18   mov   esi,[loc_0000000000501a64h]
> 0033:00000000_00400C1E   test   esi,esi
> 0033:00000000_00400C20   jz   loc_0000000000400c30h
> ...etc)
> to kernel virtual address space?

The tool should be able to show you virtual addresses. Those are the virtual
addresses the kernel uses.

-Andi
