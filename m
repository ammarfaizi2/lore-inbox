Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272240AbRIUIj1>; Fri, 21 Sep 2001 04:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272244AbRIUIjR>; Fri, 21 Sep 2001 04:39:17 -0400
Received: from Morgoth.esiway.net ([193.194.16.157]:54536 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S272240AbRIUIjL>; Fri, 21 Sep 2001 04:39:11 -0400
Date: Fri, 21 Sep 2001 10:39:27 +0200 (CEST)
From: Marco Colombo <marco@esi.it>
To: Radivoje Todorovic <radivojet@jaspur.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.0 and QoS installation
In-Reply-To: <NEBBJJBDIJBKDNLLLHFCEELOCCAA.radivojet@jaspur.com>
Message-ID: <Pine.LNX.4.33.0109211037450.8745-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Sep 2001, Radivoje Todorovic wrote:

> I have untared SAME linux-2.4.0.tar.gz on two PCs and when I did
> make menuconfig in the networking section, only on one of the two machines
> there was a choice to use QoS and Fair Queueing.
>
> What is the trick? Or what HW check menuconfig performed before it created
> the menu?
> Rade

diff is your friend: just have a look at the differences between the
two .config. Anyway, I'd bet you enabled CONFIG_EXPERIMENTAL only on one
of the two.

.TM.
-- 
      ____/  ____/   /
     /      /       /			Marco Colombo
    ___/  ___  /   /		      Technical Manager
   /          /   /			 ESI s.r.l.
 _____/ _____/  _/		       Colombo@ESI.it

