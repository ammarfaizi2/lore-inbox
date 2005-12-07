Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751757AbVLGS4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751757AbVLGS4u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 13:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751763AbVLGS4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 13:56:49 -0500
Received: from gold.veritas.com ([143.127.12.110]:65442 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751760AbVLGS4s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 13:56:48 -0500
Date: Wed, 7 Dec 2005 18:56:04 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Ryan Richter <ryan@tau.solarneutrino.net>
cc: Linus Torvalds <torvalds@osdl.org>,
       Kai Makisara <Kai.Makisara@kolumbus.fi>, Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@steeleye.com>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: Fw: crash on x86_64 - mm related?
In-Reply-To: <20051207183047.GA12857@tau.solarneutrino.net>
Message-ID: <Pine.LNX.4.61.0512071844560.3335@goblin.wat.veritas.com>
References: <Pine.LNX.4.63.0512012040390.5777@kai.makisara.local>
 <Pine.LNX.4.64.0512011136000.3099@g5.osdl.org> <20051201195657.GB7236@tau.solarneutrino.net>
 <Pine.LNX.4.61.0512012008420.28450@goblin.wat.veritas.com>
 <20051202180326.GB7634@tau.solarneutrino.net>
 <Pine.LNX.4.61.0512021856170.4940@goblin.wat.veritas.com>
 <20051202194447.GA7679@tau.solarneutrino.net>
 <Pine.LNX.4.61.0512022037230.6058@goblin.wat.veritas.com>
 <20051206160815.GC11560@tau.solarneutrino.net>
 <Pine.LNX.4.61.0512062025230.28217@goblin.wat.veritas.com>
 <20051207183047.GA12857@tau.solarneutrino.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 07 Dec 2005 18:56:07.0150 (UTC) FILETIME=[E15F20E0:01C5FB5F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Dec 2005, Ryan Richter wrote:

> I don't know if this is related, but in the last couple days I've seen
> hundreds of these messages from this machine (and I haven't seen it
> before):
> 
> Hangcheck: hangcheck value past margin!

I'm unclear whether you rebooted after the "general protection fault"
and "NMI Watchdog" messages (if you had to, I'm sure you did, but I
don't know whether the machine appeared to work on after those).

If you didn't reboot, then discount these "Hangcheck" messages as a
consequence of the earlier errors, and reboot as soon as convenient.
It's interesting for me to see the Bad page state, Bad page state,
BUG in mm.h, BUG in rmap.c; but after those you ought to reboot.

If you did reboot, well, maybe related, but it doesn't tell us much.

Hugh
