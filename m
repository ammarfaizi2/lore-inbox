Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750914AbWA2LPk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbWA2LPk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 06:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750918AbWA2LPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 06:15:39 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:19630 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750912AbWA2LPj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 06:15:39 -0500
Date: Sun, 29 Jan 2006 12:15:23 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
cc: bzolnier@gmail.com, mrmacman_g4@mac.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, acahalan@gmail.com
Subject: Re: CD writing in future Linux try #2 [ was: Re: CD writing in future
 Linux (stirring up a hornets' nest) ]
In-Reply-To: <43DCA097.nailGPD11GI11@burner>
Message-ID: <Pine.LNX.4.61.0601291212360.18492@yvahk01.tjqt.qr>
References: <58cb370e0601270837h61ac2b03uee84c0fa9a92bc28@mail.gmail.com>
 <43DCA097.nailGPD11GI11@burner>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Testing could be done the following way:
>
>-	insert a blank CD into your writer and do an initial test burn.
>
>	sdd -inull bs=2352 of= test.raw count=75x60x74
>	cdrecord dev=ATA:b,t,0 -audio -sao -v test.raw
>
>	Remember the speed that should be > 40x

Does speed==40 also suffice?
How about a DVD at 8x speed? (Even faster than CD at 40x)



Jan Engelhardt
-- 
| Software Engineer and Linux/Unix Network Administrator
| Alphagate Systems, http://alphagate.hopto.org/
| jengelh's site, http://jengelh.hopto.org/
