Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbVH3Opp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbVH3Opp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 10:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbVH3Opo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 10:45:44 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:22320
	"EHLO g5.random") by vger.kernel.org with ESMTP id S932147AbVH3Opo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 10:45:44 -0400
Date: Tue, 30 Aug 2005 16:45:40 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: Sven Ladegast <sven@linux4geeks.de>, linux-kernel@vger.kernel.org
Subject: Re: KLive: Linux Kernel Live Usage Monitor
Message-ID: <20050830144540.GM8515@g5.random>
References: <20050830030959.GC8515@g5.random> <Pine.LNX.4.63.0508300954190.1984@cassini.linux4geeks.de> <20050830082901.GA25438@bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050830082901.GA25438@bitwizard.nl>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2005 at 10:29:01AM +0200, Rogier Wolff wrote:
> sending a packet on the first day) The number of these random packets
> recieved is a measure of the number of CPU-months that the kernel
> runs. 

This is more or less what klive currently does, except it's a bit more
sophisticated than that, so you don't risk to lose uptime if a udp
packet is lost (or if the server goes down, or if dns resolution fails),
and secondly currently klive gets right suspend to disk. But it still
gets right suspend to disk, when system is suspended that's not
accounted as "uptime".
