Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760042AbWLEOXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760042AbWLEOXz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 09:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760136AbWLEOXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 09:23:55 -0500
Received: from allen.werkleitz.de ([80.190.251.108]:58973 "EHLO
	allen.werkleitz.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760042AbWLEOXy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 09:23:54 -0500
Date: Tue, 5 Dec 2006 15:23:39 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Florian Festi <florian@festi.info>, vojtech@suse.cz,
       linux-kernel@vger.kernel.org
Message-ID: <20061205142339.GA31748@linuxtv.org>
References: <45753BB1.6030102@festi.info> <20061205111541.GB6987@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061205111541.GB6987@elf.ucw.cz>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: 84.190.172.125
Subject: Re: Meaning of keycodes unclear
X-SA-Exim-Version: 4.2.1 (built Mon, 27 Mar 2006 13:42:28 +0200)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2006 at 12:15:41PM +0100, Pavel Machek wrote:
> On Tue 2006-12-05 10:28:17, Florian Festi wrote:
> > I am looking for the meaning of the following key codes as #defined in 
> > include/linux/input.h. I need to know what hardware produces the keycode 
> > and what happens/should happen when the corresponding key is pressed.
> > 
> > KEY_AB

I'm guessing it's "A/B" key on (TV) remote control, e.g. to switch between
two input sources

> > KEY_ANGLE

probably DVD or set-top-box remote control key to switch
between alternate video streams (video viewing angle / camera position)

> > KEY_LIST

might be used on TV remote control for "channel list"

> > KEY_RED, KEY_GREEN, KEY_YELLOW, KEY_BLUE  # Video text navigation?
> 
> Yes.

these are really application-defined multi-purpose keys,
not just limited to teletext; present on every European
TV or set-top-box remote control


HTH,
Johannes
