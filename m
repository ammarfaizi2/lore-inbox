Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265014AbUEVAXT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265014AbUEVAXT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 20:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265067AbUEVAUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 20:20:20 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:64684 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S265125AbUEVARv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 20:17:51 -0400
Subject: Re: Sluggish performances with FreeBSD
From: Laurent Goujon <laurent.goujon@online.fr>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: Rudo Thomas <rudo@matfyz.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <20040521205503.A18763@electric-eye.fr.zoreil.com>
References: <1085080302.7764.20.camel@caribou.no-ip.org>
	 <20040520193406.GA16184@ss1000.ms.mff.cuni.cz>
	 <1085083195.4240.4.camel@caribou.no-ip.org>
	 <20040520232957.A2172@electric-eye.fr.zoreil.com>
	 <1085091424.4238.13.camel@caribou.no-ip.org>
	 <20040521003616.D2172@electric-eye.fr.zoreil.com>
	 <1085093395.4238.22.camel@caribou.no-ip.org>
	 <20040521205503.A18763@electric-eye.fr.zoreil.com>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1085185065.4277.0.camel@caribou.no-ip.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.7-2mdk 
Date: Sat, 22 May 2004 02:17:45 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le ven, 21/05/2004 à 20:55 +0200, Francois Romieu a écrit :
> Laurent Goujon <laurent.goujon@online.fr> :
> [...]
> > > This one is probably for Daniele Venzano (webvenza@libero.it).
> > > You should check the l-k archive from 05/18/2004 and 05/19/2004
> > > (search for the subject: Re: [PATCH] Sis900 bug fixes 3/4).
> > I've checked this one before posting but in my case, I've only one PHY
> > transceiver according to dmesg, so this patch has probably no effect...
> 
> Right. Care to send 'mii-tool -vv' before we resort to crystal ball ?
Here we go..

eth0: negotiated 100baseTx-FD, link ok
  registers for MII PHY 1:
    3100 786d 2000 5c30 01e1 45e1 0007 2801
    0000 0000 0000 0000 0000 0000 0000 0000
    0015 0000 0000 0000 0000 0000 0100 0030
    0000 0061 0804 8800 0000 0000 0000 0000
  product info: vendor 08:00:17, model 3 rev 0
  basic mode:   autonegotiation enabled
  basic status: autonegotiation complete, link ok
  capabilities: 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD
  advertising:  100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD
  link partner: 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD
flow-control

Laurent
> 
> --
> Ueimor


