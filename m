Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317532AbSFKUVK>; Tue, 11 Jun 2002 16:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317533AbSFKUVJ>; Tue, 11 Jun 2002 16:21:09 -0400
Received: from adsl-212-59-30-243.takas.lt ([212.59.30.243]:9715 "EHLO
	mg.homelinux.net") by vger.kernel.org with ESMTP id <S317532AbSFKUVJ>;
	Tue, 11 Jun 2002 16:21:09 -0400
Date: Tue, 11 Jun 2002 22:20:42 +0200
From: Marius Gedminas <mgedmin@centras.lt>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Bandwidth 'depredation' revisited
Message-ID: <20020611202042.GC21994@gintaras>
Mail-Followup-To: Linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3D05EEAF.mailZE11URHZ@viadomus.com> <3D060FF6.5000409@fugmann.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-URL: http://ice.dammit.lt/~mgedmin/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2002 at 04:57:58PM +0200, Anders Fugmann wrote:
> tc qdisc add dev eth0 handle ffff: ingress

Does this work with 2.2 kernels?  I've enabled CONFIG_NET_CLS_POLICE,
but tc just barfs

  RTNETLINK answers: No such file or directory

Shaping with CBQ works fine.  Debian Woody, iproute 20010824-8.

Marius Gedminas
-- 
Q:      Why do mountain climbers rope themselves together?
A:      To prevent the sensible ones from going home.
