Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313416AbSFXNzx>; Mon, 24 Jun 2002 09:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313421AbSFXNzw>; Mon, 24 Jun 2002 09:55:52 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:28428 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313416AbSFXNzv>; Mon, 24 Jun 2002 09:55:51 -0400
Subject: Re: PROBLEM: 2.4.19-pre10-ac2 bug in page_alloc.c:131
To: alex@PolesApart.dhs.org (Alexandre P. Nunes)
Date: Mon, 24 Jun 2002 15:17:50 +0100 (BST)
Cc: markus_schoder@yahoo.de (Markus Schoder), linux-kernel@vger.kernel.org
In-Reply-To: <3D170F37.7000900@PolesApart.dhs.org> from "Alexandre P. Nunes" at Jun 24, 2002 09:23:19 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17MUf8-00088K-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> report. It's possible that the NVdriver module is the cause of the 
> problem, but the bug spots in kernel's vm, in a place which it's no 
> supposed to, at the point I understand. So, or the module does something 
> very ugly, or the kernel really have a bug, or yet it's nothing related 
> to the nvdriver. Unfortunately, the backtrace don't help me figuring 
> that out, since I'm no vm expert, but perhaps someone will. I may 
> attempt to forward this to Nvidia folks, but reporting a bug which only 
> spotted once and in a "pre" series kernel may hurt their feelings...

Their problem - they have our source we dont have theirs. If it occurs
with nvdriver ever loaded in that boot send it to nvidia or duplicate it
from a cold boot without the driver ever loadinhg
