Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261660AbVGaJsm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbVGaJsm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 05:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261859AbVGaJsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 05:48:42 -0400
Received: from ore.jhcloos.com ([64.240.156.239]:31500 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id S261660AbVGaJsA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 05:48:00 -0400
To: Pavel Machek <pavel@ucw.cz>
Cc: Brian Schau <brian@schau.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Wireless Security Lock driver.
From: James Cloos <cloos@jhcloos.com>
In-Reply-To: <20050730203159.GB9418@elf.ucw.cz> (Pavel Machek's message of "Sat, 30 Jul 2005 22:31:59 +0200")
References: <42EB940E.5000008@schau.com> <20050730194215.GA9188@elf.ucw.cz>
	<42EBDEA9.60505@schau.com> <20050730203159.GB9418@elf.ucw.cz>
X-Hashcash: 1:21:050731:pavel@ucw.cz::YkMCDAejjA1A0Mq9:00000LlTF
X-Hashcash: 1:21:050731:brian@schau.com::fTolTsv8Dat1Yc4Q:009lJN
X-Hashcash: 1:21:050731:linux-kernel@vger.kernel.org::8NQqz0ueA8CfW6sq:00000000000000000000000000000000031AJ
Date: Sun, 31 Jul 2005 04:42:16 -0400
Message-ID: <m3mzo3jriv.fsf@lugabout.cloos.reno.nv.us>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Pavel" == Pavel Machek <pavel@ucw.cz> writes:

Pavel> Well, that is if you use /dev/psaux, right? Using event devices
Pavel> you should be able to access it from userland.

Would /dev/input/mice not also be affected?

Until X can hotplug input devices /dev/input/mice rather than evdev
will remain necessary in many cases for a reasonable user experience.

So at least a quirk/whatever to keep that device from being included
in mice (and psaux) should be added.

-JimC
-- 
James H. Cloos, Jr. <cloos@jhcloos.com>
