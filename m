Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261495AbTADVDy>; Sat, 4 Jan 2003 16:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261518AbTADVDy>; Sat, 4 Jan 2003 16:03:54 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:33552 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261495AbTADVDx>; Sat, 4 Jan 2003 16:03:53 -0500
Date: Sat, 4 Jan 2003 21:12:24 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
cc: Antonino Daplas <adaplas@pol.net>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][FBDEV]: fb_putcs() and fb_setfont() methods
In-Reply-To: <20030104204131.GD1319@ppc.vc.cvut.cz>
Message-ID: <Pine.LNX.4.44.0301042109340.24903-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'll be happier with character coordinates for text mode. 

Yuck!! Using fbcon for text modes is just bloat. For hardware text mode it 
is much better to write a nice small console driver like newport_con.c

> could decide on case-by-case basis whether it will use its own code or 
> generic without touching pointer (without modifying potentially constant
> fb_ops structure common to all fbdev instances).

The patch was rejected. I working on your driver. I can throw in a text 
mode driver as well. 

