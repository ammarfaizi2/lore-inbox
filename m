Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030182AbVIAPFb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030182AbVIAPFb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 11:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030181AbVIAPE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 11:04:57 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:47029 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S965181AbVIAPEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 11:04:55 -0400
Date: Wed, 31 Aug 2005 20:32:00 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Rogier Wolff <R.E.Wolff@BitWizard.nl>,
       Sven Ladegast <sven@linux4geeks.de>, linux-kernel@vger.kernel.org
Subject: Re: KLive: Linux Kernel Live Usage Monitor
Message-ID: <20050831183159.GD703@openzaurus.ucw.cz>
References: <20050830030959.GC8515@g5.random> <Pine.LNX.4.63.0508300954190.1984@cassini.linux4geeks.de> <20050830082901.GA25438@bitwizard.nl> <Pine.LNX.4.63.0508301044150.1984@cassini.linux4geeks.de> <20050830094058.GA29214@bitwizard.nl> <20050830151035.GO8515@g5.random> <1125419618.8276.30.camel@localhost.localdomain> <20050830161634.GR8515@g5.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050830161634.GR8515@g5.random>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > tiny C program or a shell script using netcat.
> > 
> > echo "Reporting boot: "
> > (echo "BOOT:"_(cat /etc/lum-serial)":"_(uname -a)"::") | nc -u -w 10
> > testhost.example.com 7658
> 
> Client completely stateless couldn't get right suspend to disk as far as
> I can tell.

I'd say "ignore suspend". Machines using it are probably not connected
to network, anyway, and it stresses system quite a lot.

I'm afraid that if you compared completely idle system and system running
one hour a day, suspended for the rest, the first system would likely reach better
uptime.
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

