Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262471AbUCWKh4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 05:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbUCWKhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 05:37:55 -0500
Received: from hexagon.stack.nl ([131.155.140.144]:28406 "EHLO
	hexagon.stack.nl") by vger.kernel.org with ESMTP id S262450AbUCWKfm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 05:35:42 -0500
Date: Tue, 23 Mar 2004 11:35:40 +0100 (CET)
From: Jos Hulzink <josh@stack.nl>
To: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: OSS: cleanup or throw away
In-Reply-To: <20040323082338.GD23546@lgb.hu>
Message-ID: <20040323112305.F52644@toad.stack.nl>
References: <200403221955.52767.jos@hulzink.net> <20040322202220.GA13042@mulix.org>
 <20040323082338.GD23546@lgb.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Mar 2004, [iso-8859-2] Gábor Lénárt wrote:

> Or better: since both of OSS and ALSA are sound systems, let OSS maintainers
> start hacking ALSA, so missing parts in ALSA which presents in OSS can be
> implemented. Having one sound system would be better, especially in the
> official kernel tree. It's another story, if you have multiple one outside
> the "official" kernel source. imho.

Maybe we should start ditching OSS drivers of cards that are known to work
"reasonably well" in ALSA. If someone starts screaming "I need OSS for the
ALSA driver contains a bug", that bug might even be located and dealt with
much sooner. The ALSA OSS emulation is good enough for user land
applications to survive I think, so it's just a matter of driver bugs.

This way we end with a list of OSS drivers that are not ported yet or that
never will be ported.

OTOH, I don't know how the big bosses here think about ditching OSS
from a stable kernel tree... Can imagine they think it is not done.

Jos
