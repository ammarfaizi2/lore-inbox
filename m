Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270686AbTHKUFi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 16:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272570AbTHKUFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 16:05:38 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:34794 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S270686AbTHKUFh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 16:05:37 -0400
Date: Mon, 11 Aug 2003 22:04:32 +0200
From: Pavel Machek <pavel@suse.cz>
To: Gerd Knorr <kraxel@suse.de>
Cc: Christoph Bartelmus <columbus@hit.handshake.de>,
       lirc-list@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       vojtech@suse.cz
Subject: Re: [PATCH] lirc for 2.5/2.6 kernels - 20030802
Message-ID: <20030811200432.GS2627@elf.ucw.cz>
References: <1059820741.3116.24.camel@laurelin> <20030807214311.GC211@elf.ucw.cz> <1060334463.5037.13.camel@defiant.flameeyes> <20030808231733.GF389@elf.ucw.cz> <8rZ2nqa1z9B@hit-columbus.hit.handshake.de> <20030811124744.GB1733@elf.ucw.cz> <20030811183132.GB17777@bytesex.org> <20030811185914.GK2627@elf.ucw.cz> <20030811195422.GA25598@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030811195422.GA25598@bytesex.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Yes, that might be even better. I'd like to have ir drivers at one
> > place, but if theres enough advantage the other way...
> 
> Yes, there is:  I can just put the IR info into the card database.
> The poll thread can go away, instead I can hook gpio readouts into the
> IRQ handler.  Probing is just one or two lines in bttv-cards.c, ...

Well, that looks really nice!

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
