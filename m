Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261502AbVFFPJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261502AbVFFPJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 11:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbVFFPJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 11:09:27 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:32450 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261286AbVFFPJX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 11:09:23 -0400
Date: Mon, 6 Jun 2005 17:09:09 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Bizarre oops after suspend to RAM (was: Re: [ACPI] Resume from Suspend to RAM)
Message-ID: <20050606150909.GA2230@elf.ucw.cz>
References: <200506051456.44810.hugelmopf@web.de> <1117978635.6648.136.camel@tyrosine> <200506051732.08854.stefandoesinger@gmx.at> <1118053578.6648.142.camel@tyrosine> <1118056003.6648.148.camel@tyrosine> <20050606144501.GB2243@elf.ucw.cz> <20050606145429.GA18396@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050606145429.GA18396@srcf.ucam.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > NULL pointer dereference in filp_open; whats that strange about it?
> > Use printks to debug this one, nothing mysterious.
> 
> I can't see any way that a null pointer could get to filp_open without 
> something already being very wrong - the kernel worked fine before 
> suspend. Unfortunately, that's the one occasion that we've got the 
> machine (an HP nc4000) to resume. Since then, it simply freezes before 
> hitting "Back to C" despite having had no kernel or configuration 
> changes. The behaviour is very non-deterministic, which makes me wonder 
> about something in the suspend or resume process damaging state.

Hmm, strange. You may want to test if length of sleep affects it...

									Pavel
