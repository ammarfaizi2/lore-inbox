Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264596AbTLTKMn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 05:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264602AbTLTKMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 05:12:43 -0500
Received: from slimnet.xs4all.nl ([194.109.194.192]:32147 "EHLO slimnas.slim")
	by vger.kernel.org with ESMTP id S264596AbTLTKMl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 05:12:41 -0500
Subject: Re: [2.6.0 cpufreq] longhaul trouble
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031219180406.GA24413@redhat.com>
References: <1071851531.9835.5.camel@paragon.slim>
	 <20031219180406.GA24413@redhat.com>
Content-Type: text/plain
Message-Id: <1071915226.10008.7.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sat, 20 Dec 2003 11:13:46 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes it does!

from dmesg:

longhaul: VIA C3 'Ezra' [C5C] CPU detected. Longhaul v1 supported.
longhaul: MinMult=3.0x MaxMult=6.0x
longhaul: FSB: 133MHz Lowestspeed=399MHz Highestspeed=798MHz

from /sys/devices/system/cpu/cpu0/cpufreq:

::::::::::::::
cpuinfo_max_freq
::::::::::::::
798
::::::::::::::
cpuinfo_min_freq
::::::::::::::
399
::::::::::::::
scaling_available_governors
::::::::::::::
performance
::::::::::::::
scaling_driver
::::::::::::::
longhaul
::::::::::::::
scaling_governor
::::::::::::::
performance
::::::::::::::
scaling_max_freq
::::::::::::::
798
::::::::::::::
scaling_min_freq
::::::::::::::
399

Next step is to actually change the frequency. I am not really sure how
to do that with sysfs yet.

Cheers,

Jurgen




