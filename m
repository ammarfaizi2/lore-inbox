Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262506AbSKRTQj>; Mon, 18 Nov 2002 14:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263968AbSKRTQj>; Mon, 18 Nov 2002 14:16:39 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:35087 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262506AbSKRTQi>; Mon, 18 Nov 2002 14:16:38 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: tco/rng support for Intel chipsets other than the i810?
Date: 18 Nov 2002 11:23:32 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <arbenk$7ct$1@cesium.transmeta.com>
References: <Pine.LNX.4.44.0211181410000.16963-100000@light.webcon.net> <3DD93CD2.10100@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3DD93CD2.10100@pobox.com>
By author:    Jeff Garzik <jgarzik@pobox.com>
In newsgroup: linux.dev.kernel
> 
> >
> > Do you think I can just add an entry into the rng_pci_tbl[] for my 845PE
> > (8086, 2560) and have it work?
> 
> I don't have the docs, so I'm guessing here, but it's entirely possible.
> 

FWIW, the Intel RNG isn't really in the chipset proper, but rather in
the "firmware hub", the glorified BIOS ROM.  The detection mechanism
is interesting, to say the least.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
