Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284181AbRLPBlM>; Sat, 15 Dec 2001 20:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284178AbRLPBkw>; Sat, 15 Dec 2001 20:40:52 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:27328 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S284176AbRLPBkk>;
	Sat, 15 Dec 2001 20:40:40 -0500
To: <linux-kernel@vger.kernel.org>
Subject: Re: dscc4 and new Generic HDLC Layer
In-Reply-To: <3C19CA22.E604CB32@cyclades.com>
	<20011214151518.B30306@xyzzy.org.uk>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 15 Dec 2001 14:33:29 +0100
In-Reply-To: <20011214151518.B30306@xyzzy.org.uk>
Message-ID: <m31yhwppzq.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bob Dunlop <bob.dunlop@xyzzy.org.uk> writes:

> The patch repeats some of Krzystofs changes so I can't apply it over the
> top of his patch but at the same time it doesn't include the changes for
> FarSite, SBE Inc or you own Cyclades cards.  Better to have a patch that
> brings all the drivers up to spec in one hit surely.

Forget wanxl, it's not yet ready. Forget pc300too, I'm probably going
to keep it outside the main kernel.
Anyway, incremental patch is better, I'm going to submit my paches
to 2.5 after some features (FR InARP, DCD handling, probably FR bridging)
are added and tested.

> Probably too late to get API changes into 2.4.x, but we should get the
> generic HDLC layer into 2.5.x ASAP IMHO.  Then you might be able to argue
> for a backport into 2.4.x in the future.

Seems it's better to include that things in 2.4 when it works fine.
Especially if all drivers are updated.
2.5 first - of course.
-- 
Krzysztof Halasa
Network Administrator
