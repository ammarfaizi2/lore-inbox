Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281312AbRKEUWk>; Mon, 5 Nov 2001 15:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281315AbRKEUWc>; Mon, 5 Nov 2001 15:22:32 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:60422 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281314AbRKEUWP>; Mon, 5 Nov 2001 15:22:15 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Limited RAM - how to save it?
Date: 5 Nov 2001 12:21:51 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9s6scv$hq0$1@cesium.transmeta.com>
In-Reply-To: <20011105125231.A3783@microdata-pos.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20011105125231.A3783@microdata-pos.de>
By author:    Jan-Benedict Glaw <jbglaw@microdata-pos.de>
In newsgroup: linux.dev.kernel
> 
> I'm working on a 4MB linux system (for a customer) which has quite
> limited resources at all:
> 
> 	- 4MB RAM
> 	- 386 or 486 like processor (9..16 BogoMIPS)
> 	- < 100MB HDD
> 	- Quite a lot user space running:-(
> 
> For me, 4MB seems to be a problem. I've stripped diwn the applications
> quite a lot, but 4MB behaves very slow and unresponsible. Adding only
> one more MB solves any performance problem! I've made a small patch
> practically removing printk() from kernel which helps a lot (patch
> attached below). Basically, the running kernel is ~160KB smaller!
> Are there further methods of saving space? I've already done some
> other things, but these don't help that much:
> 

4 MB was the practical minimum for even the very early versions of
Linux.  I would probably suggest backrevving to 2.0 (which is still
maintained) or even 1.2 (which isn't) for a start...

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
