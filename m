Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263151AbUKTSwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263151AbUKTSwt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 13:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263154AbUKTSwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 13:52:49 -0500
Received: from gprs214-174.eurotel.cz ([160.218.214.174]:55680 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263151AbUKTSvj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 13:51:39 -0500
Date: Sat, 20 Nov 2004 19:51:00 +0100
From: Pavel Machek <pavel@ucw.cz>
To: John Mock <kd6pag@qsl.net>
Cc: linux-kernel@vger.kernel.org, perex@suse.cz
Subject: Re: 2.6.10-rc2 on VAIO laptop and PowerMac 8500/G3
Message-ID: <20041120185100.GA1205@elf.ucw.cz>
References: <E1CVYZM-0000Fi-00@penngrove.fdns.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CVYZM-0000Fi-00@penngrove.fdns.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The software suspend issue was long and tedious to narrow down.  Yep, as
> you suspected, it appears to be specific a driver (or group thereof).  It
> appears to happen when the sound subsystem is included.  Attached below 
> is the .config and a 'diff' from the losing one to one which works.

Okay, this is for the alsa team then. Somewhere between 2.6.10-rc1 and
2.6.10-rc2, ALSA started breaking swsusp :-(.
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
