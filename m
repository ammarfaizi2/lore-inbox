Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131508AbRC3Qea>; Fri, 30 Mar 2001 11:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131534AbRC3QeV>; Fri, 30 Mar 2001 11:34:21 -0500
Received: from ferret.phonewave.net ([208.138.51.183]:51470 "EHLO
	tarot.mentasm.org") by vger.kernel.org with ESMTP
	id <S131508AbRC3QeC>; Fri, 30 Mar 2001 11:34:02 -0500
Date: Fri, 30 Mar 2001 08:32:39 -0800
To: Frank de Lange <frank@unternet.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.3: still experiencing APIC-related hangs
Message-ID: <20010330083239.A3410@ferret.phonewave.net>
In-Reply-To: <20010330143224.A23427@unternet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010330143224.A23427@unternet.org>; from frank@unternet.org on Fri, Mar 30, 2001 at 02:32:24PM +0200
From: idalton@ferret.phonewave.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 30, 2001 at 02:32:24PM +0200, Frank de Lange wrote:
> Hi'all,
> 
> Subject says it all: 2.4.3 (unpatchaed) is still causing the dreaded
> APIC-related hangs on SMP BX systems (Abit BP-6, maybe Gigabyte). I still need
> to apply one of Maciej's patches to get rid of these hangs. The source comments
> in arc/i386/kernel/apic.c ("If focus CPU is disabled then the hang goes away")
> are incorrect, as the hang does not go away by simply disabling focus CPU. The
> only way for me to get rid of the hangs is to apply patch-2.4.1-io_apic-46
> (which does the LEVEL->EDGE->LEVEL triggered trick to 'free' the IO_APIC). I've
> been running with this patch for quite some time now, and have not experienced
> any problems with it. Maybe it it time to include it in the main kernel,
> perhaps as a configurable option ("BROKEN_IO_APIC")?
> 
> Maciej, did you submit the patch to Linus? It really seems to solve the
> (occurence of the) problems with these boards...

Where is this patch found? I am not seeing it so far on kernel.org.

-- Ferret

