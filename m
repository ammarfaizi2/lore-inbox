Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbUC1QcR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 11:32:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261996AbUC1QcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 11:32:17 -0500
Received: from adsl-67-120-171-161.dsl.lsan03.pacbell.net ([67.120.171.161]:35456
	"HELO home.linuxace.com") by vger.kernel.org with SMTP
	id S261984AbUC1QcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 11:32:13 -0500
Date: Sun, 28 Mar 2004 08:32:10 -0800
From: Phil Oester <kernel@linuxace.com>
To: Hasso Tepper <hasso@estpak.ee>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Kernel panic in 2.4.25
Message-ID: <20040328163210.GA21803@linuxace.com>
References: <200403260035.09821.hasso@estpak.ee> <200403281911.07139.hasso@estpak.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403281911.07139.hasso@estpak.ee>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having similar problems, and wonder:

1) Is the box also serving as a firewall (iptables)?

2) Are you using Intel E100 nics?

Phil Oester


On Sun, Mar 28, 2004 at 07:11:06PM +0300, Hasso Tepper wrote:
> Hasso Tepper wrote:
> > It's almost 100% (sometimes it just hangs) reproducable for me
> > although in somewhat strange situation. I have to run Quagga/Zebra
> > routing suite with zebra and ospfd daemons running. Networking
> > restart script (removing 60 vlans, creating them again and
> > assigning IPs to them) leads to panic. Process isn't always
> > swapper, I have seen ip and kupdated as well, but trace is always
> > same. I can't reproduce it with 2.4.20 kernel.
> 
> It's introduced with 2.4.25-rc1 (2.4.25-pre8 is OK). And it's still 
> there in 2.4.26-rc1.
