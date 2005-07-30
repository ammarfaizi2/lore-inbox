Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263000AbVG3QSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263000AbVG3QSO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 12:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263053AbVG3QSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 12:18:14 -0400
Received: from graphe.net ([209.204.138.32]:42192 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S263000AbVG3QSK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 12:18:10 -0400
Date: Sat, 30 Jul 2005 09:18:09 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Pavel Machek <pavel@ucw.cz>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 2/4] Task notifier against mm: Implement todo list in
 task_struct
In-Reply-To: <20050730161007.GA1885@elf.ucw.cz>
Message-ID: <Pine.LNX.4.62.0507300916170.25259@graphe.net>
References: <Pine.LNX.4.62.0507291328170.5304@graphe.net>
 <Pine.LNX.4.62.0507291332100.5304@graphe.net> <20050730112241.GA1830@elf.ucw.cz>
 <Pine.LNX.4.62.0507300843100.24809@graphe.net> <20050730161007.GA1885@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Jul 2005, Pavel Machek wrote:

> > Yes I told you to remove the TIF_FREEZE patch.
> 
> Okay, I took 2.6.13-rc3-mm3, removed TIF_FREEZE patch, and applied
> your series. (This time it applied cleanly). After first suspend
> machine locked hard at time it should switch back to original
> console. On the next try, it appeared to lock up, but then I somehow
> managed to switch consoles... unfortunately it was locked up hard at
> that point, too.

Hmmm. I have only run suspend / resume in text mode so far. Switched back 
to original console means that you ran X right?

