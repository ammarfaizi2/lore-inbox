Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261845AbVCUPtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbVCUPtJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 10:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261814AbVCUPre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 10:47:34 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:48548 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261839AbVCUPp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 10:45:27 -0500
Date: Mon, 21 Mar 2005 15:39:04 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andi Kleen <ak@muc.de>
cc: Bodo Eggert <7eggert@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11.2][RFC] printk with anti-cluttering-feature
In-Reply-To: <m1is3l3v25.fsf@muc.de>
Message-ID: <Pine.LNX.4.61.0503211534120.19892@goblin.wat.veritas.com>
References: <Pine.LNX.4.58.0503200528520.2804@be1.lrz> <m1is3l3v25.fsf@muc.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Mar 2005, Andi Kleen wrote:
> Bodo Eggert <7eggert@gmx.de> writes:
> >
> > atkbd.c: Keyboard on isa0060/serio0 reports too many keys pressed.
> >  (I'm using a keyboard switch and a IBM PS/2 keyboard)
> 
> This one should be just taken out. It is as far as I can figure out
> completely useless and happens on most machines.

Heartily seconded!  I patch it out of all my kernels, I really don't
want that message every time I happen to hit an unlucky combination of
keys.  It's about as irritating as every good keystroke being greeted
by "We thank you for your keystroke, and it will be echoed shortly".

Hugh
