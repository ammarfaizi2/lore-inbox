Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbTICMRe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 08:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262002AbTICMRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 08:17:33 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:62735 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262001AbTICMRd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 08:17:33 -0400
Date: Wed, 3 Sep 2003 14:17:12 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Jamie Lokier <jamie@shareable.org>, Kars de Jong <jongk@linux-m68k.org>,
       Linux/m68k kernel mailing list 
	<linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
In-Reply-To: <Pine.GSO.4.21.0309031122460.6985-100000@waterleaf.sonytel.be>
Message-ID: <Pine.LNX.4.44.0309031407050.20748-100000@serv>
References: <Pine.GSO.4.21.0309031122460.6985-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 3 Sep 2003, Geert Uytterhoeven wrote:

> > Does the 68020 even _have_ the equivalent of a store buffer?
> 
> Good question :-)
> 
> After I sent the previous mail, I realized the '030 has 256 bytes I cache and
> 256 bytes D cache, while the '020 has 256 bytes I cache only.

BTW the 020/030 caches are VIVT (and also only writethrough), the 040/060 
caches are PIPT.

bye, Roman

