Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbVJJIZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbVJJIZK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 04:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbVJJIZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 04:25:10 -0400
Received: from calypso.frankengul.org ([62.212.121.50]:53149 "EHLO
	calypso.frankengul.org") by vger.kernel.org with ESMTP
	id S1750804AbVJJIZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 04:25:09 -0400
Date: Mon, 10 Oct 2005 10:25:07 +0200
To: "David S. Miller" <davem@davemloft.net>
Cc: debian-sparc@lists.debian.org, netfilter-devel@lists.netfilter.org,
       linux-kernel@vger.kernel.org
Subject: Re: Sparc64 U60: no iptables
Message-ID: <20051010082507.GA5157@frankengul.org>
References: <4347A731.7010509@frankengul.org> <4348EFF4.3040305@frankengul.org> <4349614F.1010408@frankengul.org> <20051009.202646.70198053.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20051009.202646.70198053.davem@davemloft.net>
User-Agent: Mutt/1.5.9i
From: seb@frankengul.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 09, 2005 at 08:26:46PM -0700, David S. Miller wrote:
> From: Sébastien Bernard <seb@frankengul.org>
> Date: Sun, 09 Oct 2005 20:28:31 +0200
> 
> > Can one explain me why this patch works on other archs, and oops on the 
> > sparc64 smp ?
> > Can one explain why I'm the only one to have this problem ?
> 
> On your Ultra60 the two physical cpus are numbered "0" and "2".
> 

Thanks for the information.

Indeed they are. Does the patch assume that cpus are numbered in a
row ?
Now, I reverted the patch for ip_tables.c, ip6_tables.c and ebtables.c.
Everything is working ok (11h uptime).

Is this problem specific to the Ultra 60 or sparc arch ?
Will a proper fix be issued for our machines ?

	Seb
