Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318757AbSHLR0N>; Mon, 12 Aug 2002 13:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318758AbSHLR0M>; Mon, 12 Aug 2002 13:26:12 -0400
Received: from mail12.speakeasy.net ([216.254.0.212]:14315 "EHLO
	mail.speakeasy.net") by vger.kernel.org with ESMTP
	id <S318757AbSHLR0M>; Mon, 12 Aug 2002 13:26:12 -0400
Subject: Re: via vp3 udma corruption
From: Ed Sweetman <safemode@speakeasy.net>
To: linux-kernel@vger.kernel.org
Cc: David Fries <dfries@mail.win.org>
In-Reply-To: <20020812170232.GC15249@kroah.com>
References: <20020811210826.GA684@spacedout.fries.net> 
	<20020812170232.GC15249@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 12 Aug 2002 13:30:00 -0400
Message-Id: <1029173401.19308.98.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I see the same kind of corruption on my board. As far as I know, since
enabling udma2 instead of letting the board goto it's default udma4, I
haven't had any of the corruption occur again.  This is better than pio
but obviously an annoyance. I'm using an abit KT7 board.  

ide chipset:
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1

Perhaps we all see udma corruption due to it detecting an udma speed
that's not supported by our chipsets?  I know my manual says UDMA66 is
the highest for my board.  

