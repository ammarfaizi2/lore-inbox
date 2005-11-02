Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965258AbVKBVdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965258AbVKBVdj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 16:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965260AbVKBVdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 16:33:39 -0500
Received: from metis.extern.pengutronix.de ([83.236.181.26]:14796 "EHLO
	metis.extern.pengutronix.de") by vger.kernel.org with ESMTP
	id S965258AbVKBVdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 16:33:38 -0500
Date: Wed, 2 Nov 2005 22:33:54 +0100
From: Robert Schwebel <robert@schwebel.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Robert Schwebel <r.schwebel@pengutronix.de>, vojtech@suse.cz,
       rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: best way to handle LEDs
Message-ID: <20051102213354.GO23316@pengutronix.de>
References: <20051101234459.GA443@elf.ucw.cz> <20051102202622.GN23316@pengutronix.de> <20051102211334.GH23943@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20051102211334.GH23943@elf.ucw.cz>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2005 at 10:13:34PM +0100, Pavel Machek wrote:
> We have some leds that are *not* on GPIO pins (like driven by
> ACPI). We'd like to support those, too.

One more argument to have a LED framework which sits ontop of a lowlevel
one. 

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9

