Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261497AbVGTTyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbVGTTyK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 15:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261499AbVGTTyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 15:54:10 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:38157 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261497AbVGTTyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 15:54:09 -0400
Date: Wed, 20 Jul 2005 21:44:57 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Lukasz Spaleniak <lspaleniak@wroc.zigzag.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel oops, fast ethernet bridge, 2.4.31
Message-ID: <20050720194457.GR8907@alpha.home.local>
References: <20050720170025.1264b68a.lspaleniak@wroc.zigzag.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050720170025.1264b68a.lspaleniak@wroc.zigzag.pl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

just some basic questions :
  - did your configuration change before the oopses started ? (eg: new
    matches, etc...)

  - did the traffic change recently (protocols, data rate) ? eg: new
    applications on the network, etc...

  - is it possible that it's being targetted by an attack where it is
    installed (unfiltered internet, holiday employees who like to play
    with the network, etc...) ?

I really find it strange that it suddenly started oopsing if nothing
changed. At least it should have been oopsing from day one.

Regards,
willy

On Wed, Jul 20, 2005 at 05:00:25PM +0200, Lukasz Spaleniak wrote:
> Hello,
> 
> I have bridge firewall (linux box) with three fast ethernet cards (one
> rtl8139 for management and two e100 for bridge). It is running 2.4.31
> kernel and iptables v1.2.11. It works ok about one month. Few weeks
> ago It started ooopsing. First thought was hardware, but it was
> replaced with a new one and problem still exist. I'm attaching 
> ksymoops analysis of ooops message. I hope I'll help.
> 
> Some facts:
> Traffic over this bridge is about ~30 MBit/sec and every frame is
> tagged with VID (802.1q). Problem exist also on 2.4.30 kernel.
> Kernel is patched with ebtables patch. Ooops completeley freezes
> machine, only hard reset takes effect. Nothing is placed into syslog.
> 
> The ksymooops analisis is attached as text file.
> 
> Anyone know this bug/problem ?
> 
> Regards,
> Lukasz Spaleniak
> 
> -- 
> spalek on wroc zigzag pl
> GCM dpu s: a--- C++ UL++++ P+ L+++ E--- W+ N+ K- w O- M V-
> PGP t--- 5 X+ R- tv-- b DI- D- G e-- h! r y+


