Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263061AbVG3QWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263061AbVG3QWg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 12:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263067AbVG3QWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 12:22:35 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:15745 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263066AbVG3QWc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 12:22:32 -0400
Date: Sat, 30 Jul 2005 18:22:23 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Christoph Lameter <christoph@lameter.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 2/4] Task notifier against mm: Implement todo list in task_struct
Message-ID: <20050730162223.GB1885@elf.ucw.cz>
References: <Pine.LNX.4.62.0507291328170.5304@graphe.net> <Pine.LNX.4.62.0507291332100.5304@graphe.net> <20050730112241.GA1830@elf.ucw.cz> <Pine.LNX.4.62.0507300843100.24809@graphe.net> <20050730161007.GA1885@elf.ucw.cz> <Pine.LNX.4.62.0507300916170.25259@graphe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0507300916170.25259@graphe.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Yes I told you to remove the TIF_FREEZE patch.
> > 
> > Okay, I took 2.6.13-rc3-mm3, removed TIF_FREEZE patch, and applied
> > your series. (This time it applied cleanly). After first suspend
> > machine locked hard at time it should switch back to original
> > console. On the next try, it appeared to lock up, but then I somehow
> > managed to switch consoles... unfortunately it was locked up hard at
> > that point, too.
> 
> Hmmm. I have only run suspend / resume in text mode so far. Switched back 
> to original console means that you ran X right?

No, I was running text consoles. vesafb in this case.

								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
