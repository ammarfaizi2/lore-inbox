Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbTHTBFo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 21:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261674AbTHTBFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 21:05:44 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:63105 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261672AbTHTBE7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 21:04:59 -0400
Date: Wed, 20 Aug 2003 02:04:24 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: [PATCH][2.6][5/5]Support for HPET based timer
Message-ID: <20030820010424.GA18581@mail.jlokier.co.uk>
References: <mmGp.wp.3@gated-at.bofh.it> <mnsM.1eL.13@gated-at.bofh.it> <moRP.2r8.11@gated-at.bofh.it> <m3vfstqie7.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3vfstqie7.fsf@averell.firstfloor.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Jamie Lokier <jamie@shareable.org> writes:
> > Even on those machines where APIC interrupts are not usable?
> > (E.g. due to interactions with the SMM BIOS).
> 
> On those you can always use the old style PIT.

Let me put the question better.  Is it worth using the new style HPET,
on systems which cannot use APIC interrupts because of BIOS problems
(e.g. IBM laptops)?

-- Jamie
