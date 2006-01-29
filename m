Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750948AbWA2Uv7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbWA2Uv7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 15:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750983AbWA2Uv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 15:51:59 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:31936 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1750941AbWA2Uv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 15:51:58 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Sun, 29 Jan 2006 21:50:18 +0100
To: matthias.andree@gmx.de, jengelh@linux01.gwdg.de
Cc: schilling@fokus.fraunhofer.de, mrmacman_g4@mac.com,
       linux-kernel@vger.kernel.org, bzolnier@gmail.com, acahalan@gmail.com
Subject: Re: CD writing in future Linux try #2 [ was: Re: CD writing in future Linux (stirring up a hornets' nest) ]
Message-ID: <43DD2A8A.nailGVQ115GOP@burner>
References: <58cb370e0601270837h61ac2b03uee84c0fa9a92bc28@mail.gmail.com>
 <43DCA097.nailGPD11GI11@burner>
 <20060129112613.GA29356@merlin.emma.line.org>
 <Pine.LNX.4.61.0601292139080.2596@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0601292139080.2596@yvahk01.tjqt.qr>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:

> >That's what I believe to be cdrecord/libscg bugs:
> >
> >1) libscg or cdrecord does not automatically probe all available
> >   transports, but only SCSI:
>
> This one is IMO just "a missing feature", as I can get the ATA/PI list using
>   cdrecord -dev=ATA: -scanbus

It cannot be fixed unless the two first bugs from my Linux kernel
bug report have been fixed.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
