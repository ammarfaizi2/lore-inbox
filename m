Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbTJDMXo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 08:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262016AbTJDMXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 08:23:43 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:27096 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262009AbTJDMXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 08:23:41 -0400
Date: Thu, 2 Oct 2003 14:51:42 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test6 APM/IDE double-suspend weirdness
Message-ID: <20031002125141.GB205@openzaurus.ucw.cz>
References: <16248.9932.145681.897552@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16248.9932.145681.897552@gargle.gargle.HOWL>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> In test6 (and test5 and possibly earlier), when suspending
> my aging Latitude with APM, the machine turns off, only to
> turn itself on again one second later with the disk spinning
> up. Then it turns itself off again a second later.
> 
> The kernel log contains:
> hda: start_power_step(step: 0)
> hda: start_power_step(step: 1)
> hda: complete_power_step(step: 1, stat: 50, err: 0)
> hda: completing PM request, suspend
> 
> Apart from this, both APM suspend and resume work fine.

Try removing pm_send_all from apm.c
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

