Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261804AbTHTIPB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 04:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbTHTINN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 04:13:13 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:31153 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S261823AbTHTIGE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 04:06:04 -0400
Date: Wed, 20 Aug 2003 10:05:54 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jamie Lokier <jamie@shareable.org>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: [PATCH][2.6][5/5]Support for HPET based timer
Message-ID: <20030820080554.GC17793@ucw.cz>
References: <mmGp.wp.3@gated-at.bofh.it> <mnsM.1eL.13@gated-at.bofh.it> <moRP.2r8.11@gated-at.bofh.it> <m3vfstqie7.fsf@averell.firstfloor.org> <20030820010424.GA18581@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030820010424.GA18581@mail.jlokier.co.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 20, 2003 at 02:04:24AM +0100, Jamie Lokier wrote:

> Andi Kleen wrote:
> > Jamie Lokier <jamie@shareable.org> writes:
> > > Even on those machines where APIC interrupts are not usable?
> > > (E.g. due to interactions with the SMM BIOS).
> > 
> > On those you can always use the old style PIT.
> 
> Let me put the question better.  Is it worth using the new style HPET,
> on systems which cannot use APIC interrupts because of BIOS problems
> (e.g. IBM laptops)?

Those don't have a HPET. Easy.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
