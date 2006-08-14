Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964982AbWHNVor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964982AbWHNVor (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 17:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964984AbWHNVoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 17:44:46 -0400
Received: from us.cactii.net ([66.160.141.151]:51972 "EHLO us.cactii.net")
	by vger.kernel.org with ESMTP id S964982AbWHNVop (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 17:44:45 -0400
Date: Mon, 14 Aug 2006 23:44:18 +0200
From: Ben B <kernel@bb.cactii.net>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Maciej Rutecki <maciej.rutecki@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc4-mm1
Message-ID: <20060814214417.GB30680@cactii.net>
References: <20060813012454.f1d52189.akpm@osdl.org> <20060813121126.b1dc22ee.akpm@osdl.org> <20060813224413.GA21959@cactii.net> <200608132000.21132.dtor@insightbb.com> <20060814120316.GB13159@cactii.net> <d120d5000608140645y585d987fj1d4927879e9b180e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000608140645y585d987fj1d4927879e9b180e@mail.gmail.com>
X-PGP-Key: 3CD061AD
X-PGP-Fingerprint: E092 32CA 6196 7C11 0692  BE43 AEDA 4D47 3CD0 61AD
Jabber-ID: bb@cactii.net
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov <dmitry.torokhov@gmail.com> uttered the following thing:
> On 8/14/06, Ben B <kernel@bb.cactii.net> wrote:
> >I can try to get a full boot log later when I get home.
> >
> 
> Please.

It was impossible to get. I set the 'init' kernel option to a dedicated
script to dump dmesg, but even that went way past the messages.

It seems however that I managed to get everything a-ok now, I just
booted with 'i8042.noaux=1' and that seemed to have resolved everything.
This lappy is proving a challenge to get perfect (but I'm getting
there!)

> > 9:         10          0   IO-APIC-level  acpi
> > 12:       1796          0    IO-APIC-edge  i8042
>               ^^^^^^^
> 
> It loos like it does (on AUX port)

Fyi, that didn't increment further no matter how much i battered the
kbd or wiggled the touchpad/stick.

Cheers,
BB

