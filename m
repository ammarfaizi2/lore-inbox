Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319645AbSIMNsE>; Fri, 13 Sep 2002 09:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319647AbSIMNsE>; Fri, 13 Sep 2002 09:48:04 -0400
Received: from pD952AD04.dip.t-dialin.net ([217.82.173.4]:61420 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S319645AbSIMNsD>; Fri, 13 Sep 2002 09:48:03 -0400
Date: Fri, 13 Sep 2002 07:52:51 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Daniel Phillips <phillips@arcor.de>
cc: Rusty Russell <rusty@rustcorp.com.au>,
       Roman Zippel <zippel@linux-m68k.org>,
       Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Alexander Viro <viro@math.psu.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Raceless module interface
In-Reply-To: <E17pqaz-000891-00@starship>
Message-ID: <Pine.LNX.4.44.0209130750270.10048-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 13 Sep 2002, Daniel Phillips wrote:
> On Friday 13 September 2002 08:51, Rusty Russell wrote:
> > [cool code]
> 
> Why is that different from:
> 
> [more code]

Because in your example, my_module_start() would not be able to run 
separately, and because, as Rusty mentioned, my_module_init() can fail 
separately (e.g. if there's no space to drop that).

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-


