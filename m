Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261564AbUKAIFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbUKAIFo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 03:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbUKAIFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 03:05:44 -0500
Received: from gprs214-33.eurotel.cz ([160.218.214.33]:16768 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261564AbUKAIFk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 03:05:40 -0500
Date: Mon, 1 Nov 2004 09:03:07 +0100
From: Pavel Machek <pavel@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: Map extra keys on compaq evo
Message-ID: <20041101080306.GA1002@elf.ucw.cz>
References: <20041031213859.GA6742@elf.ucw.cz> <200410312016.08468.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410312016.08468.dtor_core@ameritech.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Compaq Evo notebooks seem to use non-standard keycodes for their extra
> > keys. I workaround that quirk with dmi hook.
> > 
> 
> Why don't you just call "setkeycodes" from your init script?

In such case I'd need to configure keys at two different places, and
that's ugly. I have to configure these extra keys with "hotkeys"
anyway (input layer does not provide list of keys available, so
"hotkeys" . Having to configure this at two places is pretty ugly.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
