Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267563AbRGMWIK>; Fri, 13 Jul 2001 18:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267559AbRGMWHT>; Fri, 13 Jul 2001 18:07:19 -0400
Received: from carlsberg.amagerkollegiet.dk ([194.182.238.3]:54545 "EHLO
	carlsberg.amagerkollegiet.dk") by vger.kernel.org with ESMTP
	id <S267558AbRGMWHD>; Fri, 13 Jul 2001 18:07:03 -0400
Date: Sat, 14 Jul 2001 00:06:30 +0200 (CEST)
From: =?iso-8859-1?Q?Rasmus_B=F8g_Hansen?= <moffe@amagerkollegiet.dk>
To: Masaru Kawashima <masaruk@gol.com>
cc: <linux-kernel@vger.kernel.org>, <jgarzik@mandrakesoft.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Re: [MINOR PROBLEM] RTL8139C: transmit timed out
In-Reply-To: <E15L7Zp-0006k9-00@smtp01.fields.gol.com>
Message-ID: <Pine.LNX.4.33.0107140005270.1482-100000@grignard.amagerkollegiet.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Jul 2001, Masaru Kawashima wrote:

> > Jul 12 20:36:43 wiibroe kernel: NETDEV WATCHDOG: eth0: transmit timed out
> 
> I had the same problem with linux-2.4.6-ac2, and I found a bug
> in the function rtl8139_start_xmit() of 8139too.c.
> 
> Attached patch will fix this bug.

Just patched vanilla 2.4.6 - I will let you know if it really helps in a 
couple of days - thanks.

Rasmus

-- 
-- [ Rasmus 'Møffe' Bøg Hansen ] ---------------------------------------
If a trainstation is the place where trains stop, what is a workstation?
--------------------------------- [ moffe at amagerkollegiet dot dk ] --

