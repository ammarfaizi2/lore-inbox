Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273996AbRISD7c>; Tue, 18 Sep 2001 23:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273997AbRISD7X>; Tue, 18 Sep 2001 23:59:23 -0400
Received: from anime.net ([63.172.78.150]:50959 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S273996AbRISD7M>;
	Tue, 18 Sep 2001 23:59:12 -0400
Date: Tue, 18 Sep 2001 20:55:30 -0700 (PDT)
From: Dan Hollis <goemon@anime.net>
To: Carsten Leonhardt <leo@arioch.oche.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Athlon: Try this (was: Re: Athlon bug stomping #2)
In-Reply-To: <87wv2yvm3l.fsf@cymoril.oche.de>
Message-ID: <Pine.LNX.4.30.0109182053580.12146-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Sep 2001, Carsten Leonhardt wrote:
> Roberto Jung Drebes <drebes@inf.ufrgs.br> writes:
> > I tested here and it seems that bit 7 is responsible. Here is the
> > diff to pci-pc.c:
> I tried it here on my Tyan Trinity KT-A (S2390B), and it works!

Has anyone compared memcopy speed with it on and with it off?
Eg does it slow down memory accesses even slower than non-optimized
memcopy?

-Dan

-- 
[-] Omae no subete no kichi wa ore no mono da. [-]

