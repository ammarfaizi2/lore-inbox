Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275065AbTHIRRp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 13:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275231AbTHIRRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 13:17:44 -0400
Received: from ns.handshake.de ([193.141.176.10]:21509 "EHLO
	hs-gate.handshake.de") by vger.kernel.org with ESMTP
	id S275065AbTHIRP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 13:15:28 -0400
From: columbus@hit.handshake.de (Christoph Bartelmus)
X-ZC-PGP-Key-Avail: 
X-Mailer: OpenXP/32 v3.8.8 (Linux) beta
Message-ID: <8rZ2nqa1z9B@hit-columbus.hit.handshake.de>
Organization: Handshake e.V.
X-Gateway: ZCONNECT UR hit.handshake.de [DUUCP vom 25.09.2000]
In-Reply-To: <1059820741.3116.24.camel@laurelin> <20030807214311.GC211@elf.ucw.cz> <1060334463.5037.13.camel@defiant.flameeyes> <20030808231733.GF389@elf.ucw.cz>
Subject: Re: [PATCH] lirc for 2.5/2.6 kernels - 20030802
Date: 09 Aug 2003 14:46:00 GMT
To: lirc-list@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       pavel@suse.cz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Pavel Machek "pavel@suse.cz" wrote:

[...]
>>> * This looks like it should be integrated with drivers/input. After
>>>   all remote control is just a strange keyboard. What are reasons that
>>>   can't be done?

Because for most drivers the decoding is done in user space by the lircd
daemon.

[...]
> I know about lirc project, and I'd like to see it merged, but if lirc
> uses wrong interface, it is unsuitable for the kernel.

Is it the wrong interface?

> Motivation for having same code for infrared controls and normal
> keyboards: normal keyboards tend to have "play"/"stop"/"vol+"/"vol-"
> keys these days; certainly HP omnibook xe3 has them. It would be nice
> to handle them in an uniform way.

No problem. Feed these keys to lircd. Voila: uniform interface to all
applications.

There already is a patch for exactly that here:
http://sourceforge.net/tracker/
index.php?func=detail&aid=670000&group_id=5444&atid=305444

I didn't have the time yet to have a closer look at this patch.

Christoph
