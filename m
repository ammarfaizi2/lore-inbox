Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313684AbSDHQBU>; Mon, 8 Apr 2002 12:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313685AbSDHQBT>; Mon, 8 Apr 2002 12:01:19 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:44549 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S313684AbSDHQBS>; Mon, 8 Apr 2002 12:01:18 -0400
Date: Mon, 8 Apr 2002 11:58:41 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Ed Sweetman <ed.sweetman@wmich.edu>
cc: Anssi Saari <as@sci.fi>, linux-kernel@vger.kernel.org
Subject: Re: PROMBLEM: CD burning at 16x uses excessive CPU, although DMA is enabled
In-Reply-To: <1018278394.570.143.camel@psuedomode>
Message-ID: <Pine.LNX.3.96.1020408115634.21794A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 Apr 2002, Ed Sweetman wrote:

> I'm not completely sure about burning audio, but linux doesn't read
> audio cds using DMA.  It just wont on ide devices.  You can use a patch
> that allows this from andrew morton.  I dont write many audio cds so
> I've never tested it's effect on writing a cd, only reading.  I imagine
> it's not safe to use dma on raw/audio cds.  but go check it out
> anyways.  

  I've seen the patch, but the OP was posting about burning CDs. My
recollection is that even audio CDs don't use much CPU with DMA, but there
might be lots of options and stuff involved. I've asked for a breakdown of
CPU use so we can see if it's user or system, how much, etc.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

