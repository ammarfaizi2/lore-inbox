Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbTKDMwl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 07:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262225AbTKDMwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 07:52:41 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:15841 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262176AbTKDMwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 07:52:40 -0500
Date: Tue, 4 Nov 2003 13:52:38 +0100
From: Tomas Telensky <tomas@matfyz.cz>
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.4] Are jiffies in jiffies?
Message-ID: <20031104125238.GC18625@artax.karlin.mff.cuni.cz>
References: <3FA79D3A.8090308@softhome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FA79D3A.8090308@softhome.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hello!
>
>   [ I beleive this is real FAQ - so responding with private e-mails
> more appropriate.
>     ptr("RTFM") != 0 are welcome. ]
>
>   jiffies declared in kernel/timer.c.
>   Name suggests that it is incremented 100 times per second.
>   LDD2 suggests that it is incremented every 1000/HZ per second.
>
>   Is it just name misleading - or I really miss the point?
>
>   So to translate this to seconds i need (jiffies*1000/HZ)
>   and milliseconds are just (jiffies/HZ) then.

No. seconds are jiffies/HZ.
HZ = Herz = something per second :-)
HZ = something / second => second = something / HZ :-)

        Tomas

