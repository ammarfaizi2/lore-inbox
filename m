Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755373AbWKOCuL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755373AbWKOCuL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 21:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755468AbWKOCuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 21:50:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:38876 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1755373AbWKOCuK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 21:50:10 -0500
Date: Tue, 14 Nov 2006 18:49:43 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
In-Reply-To: <455A7E21.7020701@garzik.org>
Message-ID: <Pine.LNX.4.64.0611141846190.3349@woody.osdl.org>
References: <200611150059.kAF0xBTl009796@hera.kernel.org> <455A6EBF.7060200@garzik.org>
 <Pine.LNX.4.64.0611141747490.3349@woody.osdl.org> <455A7E21.7020701@garzik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 14 Nov 2006, Jeff Garzik wrote:
> 
> But not on Intel, hence the obvious whitelist question.

Hmm. Maybe. I'd be happier with a global "we can do MSI" flag, and making 
it easier for people to enable it (rather than do this one driver at a 
time). And yes, _if_ it's true that MSI works on all Intel SB/NB 
combinations, then maybe we could enable it for those systems.

In the meantime, I'm really tired of continually hearing about MSI 
problems, when there really aren't that many advantages.

> It's nice not to have to deal with shared interrupts.

I don't think "nice" is enough of an advantage to overcome "doesn't work 
on God knows how many systems".

		Linus
