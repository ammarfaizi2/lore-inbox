Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbTEEVkS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 17:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbTEEVkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 17:40:17 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:45793 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S261408AbTEEVkO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 17:40:14 -0400
Date: Tue, 29 Apr 2003 10:28:02 +0200
From: Pavel Machek <pavel@ucw.cz>
To: John Bradford <john@grabjohn.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Patrick Mochel <mochel@osdl.org>,
       Grover Andrew <andrew.grover@intel.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Subtle semantic issue with sleep callbacks in drivers
Message-ID: <20030429082801.GA10323@zaurus.ucw.cz>
References: <20030417144844.GC18749@gtf.org> <200304171509.h3HF9PS1000278@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304171509.h3HF9PS1000278@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > The video BIOS on a card often contains information that is found
> > -nowhere- else.  Not in the chip docs.  Not in a device driver.
> > Such information can and does vary from board-to-board, such as RAM
> > timings, while the chip remains unchanged.
> 
> Incidently, what happens if we:
> 
> * Suspend
> * Swap VGA card with another one
> * Restore

Thats equivalent to VGA hotplug, and is
not supported.

-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

