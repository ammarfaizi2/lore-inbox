Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272712AbRHaOmm>; Fri, 31 Aug 2001 10:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272713AbRHaOmd>; Fri, 31 Aug 2001 10:42:33 -0400
Received: from mailgate5.cinetic.de ([217.72.192.165]:10401 "EHLO
	mailgate5.cinetic.de") by vger.kernel.org with ESMTP
	id <S272712AbRHaOmS>; Fri, 31 Aug 2001 10:42:18 -0400
Date: Fri, 31 Aug 2001 16:49:34 +0200 (CEST)
From: Pascal Schmidt <pleasure.and.pain@web.de>
To: Tim Moore <timothymoore@bigfoot.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: System crashes with via82cxxx ide driver
In-Reply-To: <3B8ED6D7.CE237CE2@bigfoot.com>
Message-ID: <Pine.LNX.4.33.0108311647250.810-100000@neptune.sol.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2001, Tim Moore wrote:

> 2. The rejects didn't make any difference.  init/main.c.rej was SCSI
> hd[m-t] addresses which were easy to drop in by hand,
> drivers/block/ide.c.rej was comments & spacing, and the others were in
> Configure.help or Makefile EXTRAVERSION conflicts.  These don't matter
> in most cases where the ide patch makes sense.
Did that and tested. 2.2.20pre9 with ide-05042001 patch still crashes at
the same point with the same symptoms. I even have to pull out the power
chord for a few seconds before the system can be started again.

> I've another machine that uses the same kernel+ide:
> 00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev
> 02)
So it works for you with revision 02 and 10, but doesn't work for me with
revision 06. Strange.

-- 
Ciao, Pascal

-<[ pharao90@tzi.de, netmail 2:241/215.72, home http://cobol.cjb.net/) ]>-

