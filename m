Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270236AbRHHAM2>; Tue, 7 Aug 2001 20:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270238AbRHHAMI>; Tue, 7 Aug 2001 20:12:08 -0400
Received: from ip240.cvd2.rb1.bel.nwlink.com ([207.202.151.240]:18188 "EHLO
	zot.localdomain") by vger.kernel.org with ESMTP id <S270236AbRHHAMC>;
	Tue, 7 Aug 2001 20:12:02 -0400
To: Riley Williams <rhw@MemAlpha.CX>
Cc: Andrzej Krzysztofowicz <ankry@pg.gda.pl>,
        Michael McConnell <soruk@eridani.co.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: How does "alias ethX drivername" in modules.conf work?
In-Reply-To: <Pine.LNX.4.33.0108072359440.30936-100000@infradead.org>
From: Mark Atwood <mra@pobox.com>
Date: 07 Aug 2001 17:11:57 -0700
In-Reply-To: Riley Williams's message of "Wed, 8 Aug 2001 00:35:54 +0100 (BST)"
Message-ID: <m3g0b3v29e.fsf@flash.localdomain>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Riley Williams <rhw@MemAlpha.CX> writes:
> 
>     At the moment, you are required to group these by whether the
>     interface is static or hotplug, configuring all static interfaces
>     before any of the hotplug ones. This therefore reduces to being
>     either case (2) or (3) followed by case (4), and should be dealt
>     with accordingly.
> 
> As a result, the ONLY time I can see any problem occurring is when
> there are multiple hotplug interfaces to deal with (case (4) above),
> and this is acknowledged to be a case where some of the issues have
> not yet been fully ironed out.
> 
> Can you agree with this analysis, or have I overlooked something?

That is, yes indeed, pretty much the proper analysis, and my
situtation. My case can be summarized as one static interface,
followed by two (and if we can get the firewire stuff working, soon
potentially to be more) dynamic interfaces.


-- 
Mark Atwood   | I'm wearing black only until I find something darker.
mra@pobox.com | http://www.pobox.com/~mra
