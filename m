Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131626AbRDWJTa>; Mon, 23 Apr 2001 05:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131630AbRDWJTV>; Mon, 23 Apr 2001 05:19:21 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:3332 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131626AbRDWJTL>; Mon, 23 Apr 2001 05:19:11 -0400
Subject: Re: Problem with "su -" and kernels 2.4.3-ac11 and higher
To: whitney@math.berkeley.edu
Date: Mon, 23 Apr 2001 10:19:27 +0100 (BST)
Cc: manuel@mclure.org,
        kufel!ankry@green.mif.pg.gda.pl (Andrzej Krzysztofowicz),
        linux-kernel@vger.kernel.org
In-Reply-To: <200104230242.f3N2gns08877@adsl-209-76-109-63.dsl.snfc21.pacbell.net> from "Wayne Whitney" at Apr 22, 2001 07:42:49 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14rcVF-0007cJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Did you try nesting more than one "su -"? The first one after a boot
> > works for me - every other one fails.
> 
> Same here: the first "su -" works OK, but a second nested one hangs:

It appears to be a bug in PAM. Someone seems to reply on parent/child running
order and just got caught out

