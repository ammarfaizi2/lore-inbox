Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264709AbUFGOo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264709AbUFGOo5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 10:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264727AbUFGOo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 10:44:56 -0400
Received: from gprs214-178.eurotel.cz ([160.218.214.178]:42368 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S264709AbUFGOoz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 10:44:55 -0400
Date: Mon, 7 Jun 2004 16:44:46 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Keith Duthie <psycho@albatross.co.nz>
Cc: Sebastian Kloska <kloska@scienion.de>, linux-kernel@vger.kernel.org
Subject: Re: APM realy sucks on 2.6.x
Message-ID: <20040607144446.GC1467@elf.ucw.cz>
References: <40C0E91D.9070900@scienion.de> <20040607123839.GC11860@elf.ucw.cz> <40C46F7F.7060703@scienion.de> <Pine.LNX.4.53.0406080228110.27816@loki.albatross.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0406080228110.27816@loki.albatross.co.nz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >   So if anybody out there could give me guidance on how the apm code
> >   might interact with the ALSA sound system it would be highly
> >   appreciated....
> 
> In a word, badly. For at least one chipset, suspending while outputting
> to the pcm device causes the program outputting to the pcm device to enter
> the uninterruptible sleep state. A reboot is then required for the pcm
> device to be usable again...
> 
> (I attempted to report this back in February, but my bug report and
> workaround patch apparently didn't get through the alsa-devel spam
> filters.)

Submit a patch.. alsa developers are very unlikely to use APM.

								Pavel
-- 
934a471f20d6580d5aad759bf0d97ddc
