Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262655AbVDPM4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262655AbVDPM4N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Apr 2005 08:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262657AbVDPM4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Apr 2005 08:56:13 -0400
Received: from cantor2.suse.de ([195.135.220.15]:9391 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262655AbVDPM4K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Apr 2005 08:56:10 -0400
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ppc64: improve g5 sound headphone mute
References: <1113282436.21548.42.camel@gaston> <jell7nu6yk.fsf@sykes.suse.de>
	<1113344225.21548.108.camel@gaston> <jey8bnk4lj.fsf@sykes.suse.de>
	<1113345561.5387.114.camel@gaston> <jed5szk3gh.fsf@sykes.suse.de>
	<1113347296.5388.121.camel@gaston> <je8y3nk117.fsf@sykes.suse.de>
	<1113350355.5387.129.camel@gaston> <jefyxvruip.fsf@sykes.suse.de>
	<1113391382.5463.20.camel@gaston>
From: Andreas Schwab <schwab@suse.de>
X-Yow: Is this "BOOZE"?
Date: Sat, 16 Apr 2005 14:56:07 +0200
In-Reply-To: <1113391382.5463.20.camel@gaston> (Benjamin Herrenschmidt's
 message of "Wed, 13 Apr 2005 21:23:02 +1000")
Message-ID: <jek6n2x4m0.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> This patch fixes a couple more issues with the management of the GPIOs
> dealing with headphone and line out mute on the G5. It should fix the
> remaining problems of people not getting any sound out of the headphone
> jack.

There's still a minor problem: when booting with line-out plugged (didn't
try headphone yet) the initial volume settings are still not right.
Unplugging and plugging again fixes this.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
