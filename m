Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271196AbTHLVS4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 17:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271203AbTHLVSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 17:18:55 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:12509 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S271196AbTHLVSU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 17:18:20 -0400
Date: Tue, 12 Aug 2003 23:18:16 +0200
From: Karel Kulhavy <clock@atrey.karlin.mff.cuni.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: Possible fix for NFORCE2 IDE hangups
Message-ID: <20030812211816.GA22799@atrey.karlin.mff.cuni.cz>
References: <3F3954EB.1080406@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F3954EB.1080406@gmx.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi.
> 
> I have an ASUS A7N8X Deluxe board and had those annoying hangups when 
> the system had high disk activity.
> I tried to reduce the UDMA level or even remove the amd74xx driver from 
> my kernel and run the system with PIO, but the system still crashed from 
> time to time.

Yes, exactly the same experience. The frequency of crashes decreased,
but the crashes were definitely still there!

> 
> Last weekend I disabled the use of the APIC (the system now uses XT-PIC) 
> and this seems to fix the problem. The system ran stable with UDMA100 
> enabled for the last 4 days.

Did the famous "spurious interrupt" messages go away too?

What does it mean for enduser if he disables APIC?

I would try it, but I have returned the PC back to the shop for a
warranty repair because I assumed the southbridge is simply wrong. They
told me they'll replace the MB with KT400A piece.

Is it possible to download nforce2 datasheets somewhere?

Is it possible to download KT400A datasheets anywhere?

I'm just waiting for anyone to make a GPL chipset.

Cl<
