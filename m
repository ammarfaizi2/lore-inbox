Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272736AbRIWTYb>; Sun, 23 Sep 2001 15:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272773AbRIWTYV>; Sun, 23 Sep 2001 15:24:21 -0400
Received: from d-dialin-1785.addcom.de ([62.96.166.105]:13040 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S272736AbRIWTYR>; Sun, 23 Sep 2001 15:24:17 -0400
Date: Sun, 23 Sep 2001 21:24:11 +0200 (CEST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: <kai@vaio>
To: "Garst R. Reese" <reese@isn.net>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: do we need 10 copies?
In-Reply-To: <3BAE2283.41E7E8E8@isn.net>
Message-ID: <Pine.LNX.4.33.0109232106020.14414-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Sep 2001, Garst R. Reese wrote:

> This table (512 bytes) and the code to implement crc-ccit is replicated
> in 10 drivers. ppp-async even exports it. Surely there is a better way.

As for the ISDN code (4 copies), there is the plan to use a a common HDLC
en/decoding module, however that's a 2.5 thing. I'll take a look if I can
find a generic solution then, but it might turn out difficult - having a
module of its own just for that table wastes nearly a page, so that's
probably worse than the current state of affairs.

--Kai




