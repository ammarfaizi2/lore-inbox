Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750826AbWIFMtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbWIFMtI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 08:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750851AbWIFMtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 08:49:08 -0400
Received: from yzordderrex.netnoteinc.com ([212.17.35.167]:49340 "EHLO
	yzordderrex.lincor.com") by vger.kernel.org with ESMTP
	id S1750826AbWIFMtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 08:49:01 -0400
Message-ID: <44FEC3A4.1030108@draigBrady.com>
Date: Wed, 06 Sep 2006 13:48:36 +0100
From: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigBrady.com>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Samuel Tardieu <sam@rfc1149.net>
CC: linux-kernel@vger.kernel.org, wim@iguana.be
Subject: Re: [PATCH] watchdog: add support for w83697hg chip
References: <87fyf5jnkj.fsf@willow.rfc1149.net> <44FEAD7E.6010201@draigBrady.com> <2006-09-06-13-29-46+trackit+sam@rfc1149.net> <44FEB5B6.10008@draigBrady.com> <2006-09-06-14-07-50+trackit+sam@rfc1149.net>
In-Reply-To: <2006-09-06-14-07-50+trackit+sam@rfc1149.net>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samuel Tardieu wrote:
> On  6/09, Pádraig Brady wrote:
> 
> | So in the case the BIOS sets the watchdog to 4 mins
> | for example the 2 drivers are a little different.
> | 
> | W83627HF resets to timeout seconds on module load
> | W83697HG resets to timeout seconds on /dev/watchdog open
> 
> Yes, I'm reluctant at changing anything set by the BIOS before the first
> *use* of the module.

Sure.

> In particular, if the watchdog was not activated by
> default in the BIOS, I'd prefer the box not to reboot just because the
> module was loaded (maybe by mistake) if no daemon open /dev/watchdog
> at least once.

Of course. To clarify, the W83627HF watchdog does not enable
the watchdog on load if the BIOS had not enabled it already.

cheers,
Pádraig.
