Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964790AbWAFHxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964790AbWAFHxE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 02:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964797AbWAFHxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 02:53:04 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:10939 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S964790AbWAFHxC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 02:53:02 -0500
Date: Fri, 6 Jan 2006 08:52:29 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Adrian Bunk <bunk@stusta.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i386: let REGPARM no longer depend on EXPERIMENTAL
In-Reply-To: <20060106022503.GS12313@stusta.de>
Message-ID: <Pine.LNX.4.61.0601060851130.22809@yvahk01.tjqt.qr>
References: <20060106022503.GS12313@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>REGPARM has already gotten much testing, what about removing the 
>dependency on EXPERIMENTAL?

I had no problem with it since I started using it from 2.6.8 
on. (Some machines starting with 2.6.11 because I forgot to activate it in 
menuconfig.)

>Additionally, this patch does:
>- remove the useless "default n"
>- remove note regarding binary only modules (nowadays, there are even
>  some binary only modules compiled with REGPARM=y available)

Prop nvidia module (1.0-4496 tho) works with REGPARM=y.



Jan Engelhardt
-- 
| Alphagate Systems, http://alphagate.hopto.org/
| jengelh's site, http://jengelh.hopto.org/
