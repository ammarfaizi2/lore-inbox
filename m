Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314685AbSEMX2k>; Mon, 13 May 2002 19:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314702AbSEMX2j>; Mon, 13 May 2002 19:28:39 -0400
Received: from ip68-6-164-6.sd.sd.cox.net ([68.6.164.6]:25729 "EHLO
	rei.moonkingdom.net") by vger.kernel.org with ESMTP
	id <S314685AbSEMX2g>; Mon, 13 May 2002 19:28:36 -0400
Date: Mon, 13 May 2002 16:28:32 -0700
From: Marc Wilson <msw@cox.net>
To: linux-kernel@vger.kernel.org
Subject: Re: downgrade ata udma mode at boot time?
Message-ID: <20020513232832.GC1937@moonkingdom.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0205131521160.17160-100000@twinlark.arctic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2002 at 03:28:56PM -0700, dean gaudet wrote:
> so far in my searching i've only found the hdparm -X switch for
> downgrading the ata udma mode (to give me temporary respite from 80-pin
> cables which are too long). is there any way to do this on the kernel boot
> line?

Even Maxtor should have a utility to control what modes the drives are
allowed to use.  If your box isn't smart enough on its own to limit things
to a safe range, then grab a copy of said utility and lock the drives down
so that they CAN'T be used in UDMA5.  Most of them just require booting
from a floppy....

Not so tough.

-- 
Marc Wilson
msw@cox.net

