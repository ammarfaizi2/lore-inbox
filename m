Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270823AbTHKKOW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 06:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272445AbTHKKOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 06:14:22 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:62616 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S270823AbTHKKOV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 06:14:21 -0400
Date: Mon, 11 Aug 2003 12:14:03 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test2: unable to suspend (APM)
Message-ID: <20030811101403.GA360@elf.ucw.cz>
References: <20030806231519.H16116@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030806231519.H16116@flint.arm.linux.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I'm trying to test out APM on my laptop (in order to test some PCMCIA
> changes), but I'm hitting a brick wall.  I've added the device_suspend()
> calls for the SAVE_STATE, DISABLE and the corresponding device_resume()
> calls into apm's suspend() function.  (this is needed so that PCI
> devices receive their notifications.)

Can you verify that it is not device "vetoing" the suspend?
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
