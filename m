Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932329AbVHaBtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbVHaBtM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 21:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbVHaBtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 21:49:12 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:10510
	"EHLO g5.random") by vger.kernel.org with ESMTP id S932329AbVHaBtL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 21:49:11 -0400
Date: Wed, 31 Aug 2005 03:49:06 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>, linux-kernel@vger.kernel.org
Subject: Re: KLive: Linux Kernel Live Usage Monitor
Message-ID: <20050831014906.GO8515@g5.random>
References: <20050830030959.GC8515@g5.random> <Pine.LNX.4.63.0508300954190.1984@cassini.linux4geeks.de> <20050830082901.GA25438@bitwizard.nl> <Pine.LNX.4.63.0508301044150.1984@cassini.linux4geeks.de> <20050830094058.GA29214@bitwizard.nl> <4314D98E.2030801@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4314D98E.2030801@tmr.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2005 at 06:11:26PM -0400, Bill Davidsen wrote:
> the system, like load. A week running while I was on vacation doesn't 
> test much, a week running on a loaded server tests other things.

btw, I thought about adding the load average too but it wasn't really
interesting, since sometime a server is stressed a lot for a few minutes
and then goes back to idle mode. A kernel bug will not necessairly
trigger because some app is I/O bound all the time. Certainly more load
is a factor that increases the probability of bugs and race conditions
though, it's just not obvious how to assign a 0/100% score to a certain
KLive "session".

> The use will depend on how easy it is to install, patch and build isn't 
> easy. Crontab is. And I bet developers would be interested in how long 

crontab really is easy and standard, crontab seems actually the only way I
could really write the few liner autoinstall script.
