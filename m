Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265034AbUFANYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265034AbUFANYl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 09:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265031AbUFANYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 09:24:41 -0400
Received: from gprs214-153.eurotel.cz ([160.218.214.153]:1664 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265035AbUFANYj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 09:24:39 -0400
Date: Tue, 1 Jun 2004 15:24:29 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Alexander Gran <alex@zodiac.dnsalias.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Enable suspend/resuming of e1000
Message-ID: <20040601132429.GA5926@elf.ucw.cz>
References: <200405281404.10538@zodiac.zodiac.dnsalias.org> <20040601125008.GE10233@elf.ucw.cz> <200406011504.40549@zodiac.zodiac.dnsalias.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406011504.40549@zodiac.zodiac.dnsalias.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Whitespace damage here (tabs vs. spaces) plus you really should not
> > call procedure before variable declarations. Otherwise looks good.
> >
> > 								Pavel
> 
> Was my first patch to the kernel, sorry. However I still have trouble 
> reenabling the card. It is recognized again (Withouth the driver thinks 
> EEPROM is wrong).
> tx is ok, but rx doesn't work. I suppose it's an interrupt problem, as the 
> interrupt doesn't increase on rx. Will dig into it a bit further..

Problem with interrupts? Look if /proc/interrupts increase when you
ping it. You may want to try "noapic".
									Pavel
-- 
934a471f20d6580d5aad759bf0d97ddc
