Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266275AbUHaSPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266275AbUHaSPe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 14:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266291AbUHaSPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 14:15:34 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:6143 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266275AbUHaSPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 14:15:22 -0400
Date: Tue, 31 Aug 2004 20:15:10 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: jgarzik@pobox.com, akpm@digeo.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: net drivers depending on OBSOLETE
Message-ID: <20040831181509.GI3466@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following two net drivers depend in both 2.4 and 2.6 on OBSOLETE:
- FMV18X
- SEEQ8005
- SK_G16

Since CONFIG_OBSOLETE is never set they are not selectable.
Is there any reason why they should stay in the kernel or would you
accept a patch that removes these drivers?


More than one year ago, Alan Cox answered to the same question in two 
emails:

<--  snip  -->

... sk_g16 is a pretty rare bit of
hardware but I thought people had it working in current 2.4, fmv18x
I've no idea about. I'll take a look at them

<--  next mail  -->

[FMV18X] Seems to be a mirror of the at1700 driver. Does anyone know if 
both do the same hardware ?

<--  snip  -->


Could anyone comment on the current state of these drivers?


TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

