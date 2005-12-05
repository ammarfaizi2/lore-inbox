Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964871AbVLEXhw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964871AbVLEXhw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 18:37:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964874AbVLEXhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 18:37:51 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:9400 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964871AbVLEXhu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 18:37:50 -0500
Date: Tue, 6 Dec 2005 00:37:38 +0100
From: Pavel Machek <pavel@ucw.cz>
To: David.Ronis@mcgill.ca
Cc: linux-kernel@vger.kernel.org
Subject: Re: echo "mem" > /sys/power/state fails
Message-ID: <20051205233738.GB1770@elf.ucw.cz>
References: <1133742700.6492.3.camel@montroll.chem.mcgill.ca> <20051205211232.GA1728@elf.ucw.cz> <1133819578.5960.42.camel@montroll.chem.mcgill.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133819578.5960.42.camel@montroll.chem.mcgill.ca>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Thanks for the reply.  Unfortunately that isn't an option for me (unless
> 2.6.12.6 supports it, which I don't think it does); the 2.6.1[34] series
> are badly broken on this box; disk response is x100 slower.  The problem
> seems to be in the acpi subsystem, but I'm not sure.  It's been reported
> on this list, on the linux-ide list and most recently at
> bugzilla.kernel.org [Bug 5594]; so far nobody has come up with a
> workable fix or diagnosis (there was a suggestion about the default IRQ
> used for ide, but I couldn't find where that was set in the kernel [I've
> never hacked the kernel]).

You have to debug the irq issue first, then. You can try searching for
patch that breaks it or something like that.
								Pavel

-- 
Thanks, Sharp!
