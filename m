Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272260AbTHDV3C (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 17:29:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272259AbTHDV3C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 17:29:02 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:19351 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S272257AbTHDV1r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 17:27:47 -0400
Date: Mon, 4 Aug 2003 23:27:25 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-laptop@vger.kernel.org,
       sfr@canb.auug.org.au, david-b@pacbell.net
Subject: Re: Do not suspend PCI devices twice [PATCH for testing]
Message-ID: <20030804212724.GA2787@elf.ucw.cz>
References: <20030804212624.GA2452@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030804212624.GA2452@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> PCI devices are suspendend twice; once using pm_send_all() and once
> because of driver model (when using ACPI). That's bad.
> 
> If I kill pm_send_all() hook, they will not be suspended at all with
> APM, because APM does not call device_suspend(...,
> SUSPEND_SAVE_STATE). This patch fixes both of these.
> 
> Ouch, no it does not. You should > drivers/pci/power.c. Its no longer
> needed.
> 
> It compiles, and I'd like someone to test it ;-).

Oops, wrong patch attached.

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
