Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbUKBMFH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbUKBMFH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 07:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbUKBMFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 07:05:06 -0500
Received: from smtp-out-02.utu.fi ([130.232.202.172]:17147 "EHLO
	smtp-out-02.utu.fi") by vger.kernel.org with ESMTP id S261205AbUKBMCH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 07:02:07 -0500
Date: Tue, 02 Nov 2004 14:02:01 +0200
From: Jan Knutar <jk-lkml@sci.fi>
Subject: Re: XMMS (or some other audio player) 'hang' issues with intel8x0 and
 dmix plugin [u]
In-reply-to: <1099396329.713.4.camel@leto.cs.pocnet.net>
To: Christophe Saout <christophe@saout.de>
Cc: Martin Schlemmer <azarah@nosferatu.za.org>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       Takashi Iwai <tiwai@suse.de>, alsa-user@lists.sourceforge.net
Message-id: <200411021402.01566.jk-lkml@sci.fi>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.6.2
References: <1099284142.11924.17.camel@nosferatu.lan>
 <200411021340.03164.jk-lkml@sci.fi> <1099396329.713.4.camel@leto.cs.pocnet.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 November 2004 13:52, Christophe Saout wrote:

> > What's strange is that almost always when it happens, either mplayer or
> > beep-media-player will have an extra forked process.
> 
> This has something to do with dmix forking off a process, I don't know
> exactly what it is for, it does something with the dmix unix socket
> in /tmp.

Aha. I've also, I recall, seen player hang right on start, and then also presumably
in alsa-lib trying to open the socket in /tmp but blocking forever on that for some
reason... Intermittent bugs are the most annoying of all :-)

