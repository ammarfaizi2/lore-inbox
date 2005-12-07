Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751775AbVLGTHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751775AbVLGTHH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 14:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751773AbVLGTHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 14:07:07 -0500
Received: from solarneutrino.net ([66.199.224.43]:50693 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S1751772AbVLGTHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 14:07:03 -0500
Date: Wed, 7 Dec 2005 14:06:58 -0500
To: Hugh Dickins <hugh@veritas.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kai Makisara <Kai.Makisara@kolumbus.fi>, Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@steeleye.com>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       ryan@tau.solarneutrino.net
Subject: Re: Fw: crash on x86_64 - mm related?
Message-ID: <20051207190658.GB12857@tau.solarneutrino.net>
References: <20051201195657.GB7236@tau.solarneutrino.net> <Pine.LNX.4.61.0512012008420.28450@goblin.wat.veritas.com> <20051202180326.GB7634@tau.solarneutrino.net> <Pine.LNX.4.61.0512021856170.4940@goblin.wat.veritas.com> <20051202194447.GA7679@tau.solarneutrino.net> <Pine.LNX.4.61.0512022037230.6058@goblin.wat.veritas.com> <20051206160815.GC11560@tau.solarneutrino.net> <Pine.LNX.4.61.0512062025230.28217@goblin.wat.veritas.com> <20051207183047.GA12857@tau.solarneutrino.net> <Pine.LNX.4.61.0512071844560.3335@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0512071844560.3335@goblin.wat.veritas.com>
User-Agent: Mutt/1.5.9i
From: Ryan Richter <ryan@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2005 at 06:56:04PM +0000, Hugh Dickins wrote:
> On Wed, 7 Dec 2005, Ryan Richter wrote:
> 
> > I don't know if this is related, but in the last couple days I've seen
> > hundreds of these messages from this machine (and I haven't seen it
> > before):
> > 
> > Hangcheck: hangcheck value past margin!
> 
> I'm unclear whether you rebooted after the "general protection fault"
> and "NMI Watchdog" messages (if you had to, I'm sure you did, but I
> don't know whether the machine appeared to work on after those).
> 
> If you didn't reboot, then discount these "Hangcheck" messages as a
> consequence of the earlier errors, and reboot as soon as convenient.
> It's interesting for me to see the Bad page state, Bad page state,
> BUG in mm.h, BUG in rmap.c; but after those you ought to reboot.
> 
> If you did reboot, well, maybe related, but it doesn't tell us much.

Yep, the machine pretty much hung after that and was reset the next
morning.

-ryan
