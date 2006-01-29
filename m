Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750929AbWA2L2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbWA2L2b (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 06:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750930AbWA2L2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 06:28:31 -0500
Received: from mail.gmx.net ([213.165.64.21]:52894 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750925AbWA2L2a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 06:28:30 -0500
X-Authenticated: #428038
Date: Sun, 29 Jan 2006 12:28:25 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, bzolnier@gmail.com,
       mrmacman_g4@mac.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, acahalan@gmail.com
Subject: Re: CD writing in future Linux try #2 [ was: Re: CD writing in future Linux (stirring up a hornets' nest) ]
Message-ID: <20060129112825.GB29356@merlin.emma.line.org>
Mail-Followup-To: Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Joerg Schilling <schilling@fokus.fraunhofer.de>, bzolnier@gmail.com,
	mrmacman_g4@mac.com, linux-kernel@vger.kernel.org,
	acahalan@gmail.com
References: <58cb370e0601270837h61ac2b03uee84c0fa9a92bc28@mail.gmail.com> <43DCA097.nailGPD11GI11@burner> <Pine.LNX.4.61.0601291212360.18492@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601291212360.18492@yvahk01.tjqt.qr>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt schrieb am 2006-01-29:

> Does speed==40 also suffice?
> How about a DVD at 8x speed? (Even faster than CD at 40x)

The block size of 2352 bytes (not a power of two and not a multiple of
512 either) is important.

Just check the CPU load. The machine is pretty crawling without DMA,
with high system and I/O wait figures. Even fast machines (Athlon XP
2500+) are hogged down so much the mouse pointer gets jerky.

-- 
Matthias Andree
