Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266827AbRGTJEH>; Fri, 20 Jul 2001 05:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266818AbRGTJD5>; Fri, 20 Jul 2001 05:03:57 -0400
Received: from carlsberg.amagerkollegiet.dk ([194.182.238.3]:787 "EHLO
	carlsberg.amagerkollegiet.dk") by vger.kernel.org with ESMTP
	id <S266827AbRGTJDp>; Fri, 20 Jul 2001 05:03:45 -0400
Date: Fri, 20 Jul 2001 11:03:38 +0200 (CEST)
From: =?iso-8859-1?Q?Rasmus_B=F8g_Hansen?= <moffe@amagerkollegiet.dk>
To: Masaru Kawashima <masaruk@gol.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <jgarzik@mandrakesoft.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Re: [MINOR PROBLEM] RTL8139C: transmit timed out
In-Reply-To: <E15L7Zp-0006k9-00@smtp01.fields.gol.com>
Message-ID: <Pine.LNX.4.33.0107201102340.1200-100000@grignard.amagerkollegiet.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sat, 14 Jul 2001, Masaru Kawashima wrote:

> > Jul 12 20:36:43 wiibroe kernel: NETDEV WATCHDOG: eth0: transmit timed out
> 
> I had the same problem with linux-2.4.6-ac2, and I found a bug
> in the function rtl8139_start_xmit() of 8139too.c.
> 
> Attached patch will fix this bug.

Now the box has been running for nearly a week without any trace of 
problems, so the patch seems to be fine.

Rasmus

-- 
-- [ Rasmus 'Møffe' Bøg Hansen ] ---------------------------------------
There's no point in being grown up if you can't be childish sometimes.
                                                            -- Dr. Who
--------------------------------- [ moffe at amagerkollegiet dot dk ] --


