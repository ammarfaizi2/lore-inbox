Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267632AbTAHTMf>; Wed, 8 Jan 2003 14:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267912AbTAHTMf>; Wed, 8 Jan 2003 14:12:35 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:29189 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267632AbTAHTMe>; Wed, 8 Jan 2003 14:12:34 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: tenth post about PCI code, need help
Date: 8 Jan 2003 11:20:30 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <avhtlu$qr9$1@cesium.transmeta.com>
References: <1042049372.850.921.camel@orca.madrabbit.org> <Pine.LNX.3.95.1030108132812.28791A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.3.95.1030108132812.28791A-100000@chaos.analogic.com>
By author:    "Richard B. Johnson" <root@chaos.analogic.com>
In newsgroup: linux.dev.kernel
> 
> The problem is that he's discovered something that's not supposed
> to be in the code. Only 32-bit accesses are supposed to be made to
> the PCI controller ports. He has discovered that somebody has made
> some 8-bit accesses that will not become configuration 'transactions'
> because they are not 32 bits.
> 

Right.  That's what the code is checking for.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
