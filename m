Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317868AbSGKS2A>; Thu, 11 Jul 2002 14:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317869AbSGKS17>; Thu, 11 Jul 2002 14:27:59 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:13061 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S317868AbSGKS16>; Thu, 11 Jul 2002 14:27:58 -0400
Date: Thu, 11 Jul 2002 14:24:50 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: jbradford@dial.pipex.com
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ISAPNP SB16 card with IDE interface
In-Reply-To: <200207082150.WAA03372@darkstar.example.net>
Message-ID: <Pine.LNX.3.96.1020711131531.5065A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jul 2002 jbradford@dial.pipex.com wrote:

> Are you sure that the CD-ROM drive is jumpered correctly, because
> Windows may well not complain if it is set to 'slave', but alone on the
> bus. 

I've heard this before, are there really recent kernel versions and ATA
controllers which care? I have a file server running that way now, when I
pulled the IDE disk and added SCSI nothing broke, so it seems to not
always fail.
 
> Also, maybe I'm just being stupid, but why is it being recognised as
> ide3?  The numbering starts at 0, so if this is your third interface, it
> should be ide2.  Could you post a less-trimmed copy of your dmesg output
> to the list, (or just to me, if it'll annoy the list people). 

Good question, unless the controller is hard jumpered that way and it uses
the io address as a name. I'd like to see /proc/ide first, though.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

