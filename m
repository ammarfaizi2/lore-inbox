Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266754AbUBQXJM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 18:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266786AbUBQXJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 18:09:12 -0500
Received: from gprs159-87.eurotel.cz ([160.218.159.87]:27524 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S266754AbUBQXJG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 18:09:06 -0500
Date: Wed, 18 Feb 2004 00:08:55 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Tom Rini <trini@kernel.crashing.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][6/6] A different KGDB stub
Message-ID: <20040217230855.GB1560@elf.ucw.cz>
References: <20040217220456.GG16881@smtp.west.cox.net> <20040217223040.GA1560@elf.ucw.cz> <20040217223817.GJ16881@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040217223817.GJ16881@smtp.west.cox.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > The following is the x86_64-specific bits to this KGDB stub (Pavel, can
> > > you give this a try please?  Thanks).
> > 
> > I can only see [0/6],[1/6] and [6/6] on l-k. Could you perhaps mail me
> > complete diff against 2.6.2 to try? [Or against some other version I
> > can get from kernel.org...)
> 
> I'll blame the slow mailserver and hope they all get through
> eventually.

Yes, now only #2 is missing :-))).

> The following is the patch before I split it up.  Against 2.6.3-rc4 +
> bk-netdev from 2.6.3-rc3-mm1 (otherwise kgdboe won't work at all):

I'll try without kgdboe, first.

I'm getting some compile errors, stay tuned.

Meanwhile: [and taking this public]

arch/x86_64/kernel/x86_64-stub.c: this is really horrible name for a
file. Can we have arch/x86_64/kernel/kgdb.c? or kgdb-stub.c at worst..

also kernel/kgdb.c sounds better than kernel/kgdbstub.c.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
