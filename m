Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbWBEVw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbWBEVw4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 16:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbWBEVw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 16:52:56 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:24232 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750749AbWBEVw4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 16:52:56 -0500
Date: Sun, 5 Feb 2006 22:49:22 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH, RFC] Driver for reading HP laptop LCD brightness
Message-ID: <20060205214922.GA3681@elf.ucw.cz>
References: <20060205135517.GA21795@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060205135517.GA21795@srcf.ucam.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The attached patch provides a sysfs mechanism for reading the LCD 
> brightness on HP laptops. Since there's no clean way to determine 
> whether a machine is a laptop or not from within the kernel (this 
> information is in the DMI tables, but we don't currently export the 
> chassis field), it does nothing until userspace has enabled it.

Can you fix the DMI code to export chasis, then?

> Right now, I'm looking for comments on how to integrate it sensibly - 
> leaving it under drivers/misc and registering it as a platform device 
> /works/, but isn't terribly clean.

Lots of handhelds ave brightness settings, and it is *very* important
there. Perhaps you could use same interface?
								Pavel
-- 
Thanks, Sharp!
