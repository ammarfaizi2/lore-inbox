Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265758AbSKAVWe>; Fri, 1 Nov 2002 16:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265759AbSKAVWe>; Fri, 1 Nov 2002 16:22:34 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:39561 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265758AbSKAVWd>; Fri, 1 Nov 2002 16:22:33 -0500
Subject: Re: Sound doesn't work in 2.5.44-ac5?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0211011405230.1166-201000@oddball.prodigy.com>
References: <Pine.LNX.4.44.0211011405230.1166-201000@oddball.prodigy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 01 Nov 2002 21:48:32 +0000
Message-Id: <1036187312.12534.59.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-11-01 at 19:11, Bill Davidsen wrote:
> I must be doing something wrong, but I put in every sound card I had 
> handy, one at a time, and the modules just can't load. No warnings in make 
> modules or modules_install.
> 
> Script output attached to prevent munging, config attached if anyone has a 
> problem duplicating this.

Disable the atack checking options should I think fix it. mcount needs
to be exported _NOVERS as its asm

