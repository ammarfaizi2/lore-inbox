Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934138AbWKTMvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934138AbWKTMvf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 07:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934149AbWKTMvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 07:51:35 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:50890 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S934138AbWKTMvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 07:51:35 -0500
Subject: Re: [PATCH] PCMCIA identification strings for cards manufactured
	by Elan
From: Arjan van de Ven <arjan@infradead.org>
To: Tony Olech <tony.olech@elandigitalsystems.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
       Linux kernel development <linux-kernel@vger.kernel.org>,
       PCMCIA Maintainence <linux-pcmcia@lists.infradead.org>,
       David Hinds <dahinds@users.sourceforge.net>,
       Jaroslav Kysela <perex@suse.cz>,
       Bart Prescott <bart.prescott@elandigitalsystems.com>
In-Reply-To: <200611201214.kAKCErcU005240@imap.elan.private>
References: <200611201214.kAKCErcU005240@imap.elan.private>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 20 Nov 2006 13:51:25 +0100
Message-Id: <1164027086.31358.588.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> a card is inserted, resulting in various random lockups
> 
> *** linux-2.6.18/sound/pcmcia/pdaudiocf/pdaudiocf.c.orig	2006-11-20 10:24:23.000000000 +0000
> --- linux-2.6.18/sound/pcmcia/pdaudiocf/pdaudiocf.c	2006-11-20 10:33:46.000000000 +0000
> ***************
> *** 298,306 ****
>   /*
>    * Module entry points
>    */
>   static struct pcmcia_device_id snd_pdacf_ids[] = {
> ! 	PCMCIA_DEVICE_MANF_CARD(0x015d, 0x4c45),


please use the "-u" option for diff; that's the preferred (only) form
the Linux kernel folks are used to looking at diffs, and applying them.
Also, it's very helpful and customary to also pass the "-p" option (this
improves the context so that reviews are easier)

would you mind redoing the diff and then resending it?

Thanks!


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

