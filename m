Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272303AbTGYSD7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 14:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272304AbTGYSD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 14:03:59 -0400
Received: from devil.servak.biz ([209.124.81.2]:18116 "EHLO devil.servak.biz")
	by vger.kernel.org with ESMTP id S272303AbTGYSD4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 14:03:56 -0400
Subject: Re: Firewire
From: Torrey Hoffman <thoffman@arnor.net>
To: Chris Ruvolo <chris+lkml@ruvolo.net>
Cc: Ben Collins <bcollins@debian.org>, Sam Bromley <sbromley@cogeco.ca>,
       gaxt <gaxt@rogers.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       linux firewire devel <linux1394-devel@lists.sourceforge.net>
In-Reply-To: <20030725181303.GO23196@ruvolo.net>
References: <1059103424.24427.108.camel@daedalus.samhome.net>
	 <20030725041234.GX1512@phunnypharm.org> <20030725053920.GH23196@ruvolo.net>
	 <20030725133438.GZ1512@phunnypharm.org> <20030725142907.GI23196@ruvolo.net>
	 <20030725142926.GD1512@phunnypharm.org>
	 <20030725154009.GF1512@phunnypharm.org> <20030725160706.GK23196@ruvolo.net>
	 <20030725161803.GJ1512@phunnypharm.org>
	 <1059155483.2525.16.camel@torrey.et.myrio.com>
	 <20030725181303.GO23196@ruvolo.net>
Content-Type: text/plain
Organization: 
Message-Id: <1059157138.2525.21.camel@torrey.et.myrio.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 25 Jul 2003 11:18:59 -0700
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - devil.servak.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - arnor.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-07-25 at 11:13, Chris Ruvolo wrote:
...

> Seems that you and I have the same 1394 chipset.  I'm curious to see the 
> output from a "lspci -v -s02:0b.0".

Yup, it looks that way.  Although the PCI latency timings are different?
I think that's set up by the motherboard BIOS?  

I also have a Maxtor card with the Lucent controller chip (IIRC) that I
could try out if that would be helpful.

[root@torrey root]# lspci -v -s02:0b.0
02:0b.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host  Controller (rev 46) (prog-if 10 [OHCI])
        Subsystem: VIA Technologies, Inc. IEEE 1394 Host Controller
        Flags: bus master, medium devsel, latency 64, IRQ 10
        Memory at e8201000 (32-bit, non-prefetchable) [size=2K]
        I/O ports at 5400 [size=128]
        Capabilities: [50] Power Management version 2
 

> -Chris
> 
> 00:0b.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 46) (prog-if 10 [OHCI])
>         Subsystem: VIA Technologies, Inc. IEEE 1394 Host Controller
>         Flags: bus master, medium devsel, latency 32, IRQ 10
>         Memory at db001000 (32-bit, non-prefetchable) [size=2K]
>         I/O ports at e800 [size=128]
>         Capabilities: [50] Power Management version 2
-- 
Torrey Hoffman <thoffman@arnor.net>

