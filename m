Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbVH3Q1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbVH3Q1Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 12:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbVH3Q1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 12:27:24 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:43401 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932205AbVH3Q1Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 12:27:24 -0400
Subject: Re: KLive: Linux Kernel Live Usage Monitor
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>, Sven Ladegast <sven@linux4geeks.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050830161634.GR8515@g5.random>
References: <20050830030959.GC8515@g5.random>
	 <Pine.LNX.4.63.0508300954190.1984@cassini.linux4geeks.de>
	 <20050830082901.GA25438@bitwizard.nl>
	 <Pine.LNX.4.63.0508301044150.1984@cassini.linux4geeks.de>
	 <20050830094058.GA29214@bitwizard.nl> <20050830151035.GO8515@g5.random>
	 <1125419618.8276.30.camel@localhost.localdomain>
	 <20050830161634.GR8515@g5.random>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 30 Aug 2005 17:56:33 +0100
Message-Id: <1125420993.8276.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-08-30 at 18:16 +0200, Andrea Arcangeli wrote:
> Tiny C program will be less tiny than the current tac file and the
> package would immediately become arch dependent. 

I doubt there is anything needed that can't be done in sh and nc here.
Catching boots can be done by adding one to a boot number and sending
that as well. How does suspend to disk handle uptime - if the uptime
stops then sending the uptime will deal with it.

I'm happy to whack on some sh scripts to do the client side.

