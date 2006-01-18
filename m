Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030368AbWARQAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030368AbWARQAy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 11:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030318AbWARQAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 11:00:54 -0500
Received: from silver.veritas.com ([143.127.12.111]:55623 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1030366AbWARQAx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 11:00:53 -0500
Date: Wed, 18 Jan 2006 16:00:58 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Ryan Richter <ryan@tau.solarneutrino.net>
cc: Linus Torvalds <torvalds@osdl.org>,
       Kai Makisara <Kai.Makisara@kolumbus.fi>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org
Subject: Re: Fw: crash on x86_64 - mm related?
In-Reply-To: <20060118001252.GB821@tau.solarneutrino.net>
Message-ID: <Pine.LNX.4.61.0601181556050.9110@goblin.wat.veritas.com>
References: <Pine.LNX.4.63.0512271807130.4955@kai.makisara.local>
 <20060104172727.GA320@tau.solarneutrino.net> <Pine.LNX.4.63.0601042334310.5087@kai.makisara.local>
 <20060105201249.GB1795@tau.solarneutrino.net> <Pine.LNX.4.64.0601051312380.3169@g5.osdl.org>
 <20060109033149.GC283@tau.solarneutrino.net> <Pine.LNX.4.64.0601082000450.3169@g5.osdl.org>
 <Pine.LNX.4.61.0601090933160.7632@goblin.wat.veritas.com>
 <20060109185350.GG283@tau.solarneutrino.net> <Pine.LNX.4.61.0601091922550.15426@goblin.wat.veritas.com>
 <20060118001252.GB821@tau.solarneutrino.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 18 Jan 2006 16:00:26.0031 (UTC) FILETIME=[4BB983F0:01C61C48]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(A useless answer from me, sorry: can anyone else help?)

On Tue, 17 Jan 2006, Ryan Richter wrote:

> This machine experienced another random reboot today, nothing in the
> logs or on the console etc.  This is the 3rd time now since I upgraded
> from 2.6.11.3.  Is there any way to debug something like this?

Nasty.  I hope someone else can suggest something constructive.

> I'm fairly certain it's not hardware-related.
> Might this have something to do with the st problem?

Well, it might: I've not been able to explain that at all, so cannot
rule out a relation to your reboots.  The st problem (Bad page state,
mapcount 2 while count 0, from sgl_unmap_user_pages) ought to be a lot
easier to debug than a random reboot: but I've still no suggestion.

Hugh
