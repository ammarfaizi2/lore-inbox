Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266839AbTA0TIk>; Mon, 27 Jan 2003 14:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266926AbTA0TIk>; Mon, 27 Jan 2003 14:08:40 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:62057
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S266839AbTA0TIj>; Mon, 27 Jan 2003 14:08:39 -0500
Date: Mon, 27 Jan 2003 14:17:34 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Mike Galbraith <efault@gmx.de>
cc: Luuk van der Duim <l.a.van.der.duim@student.rug.nl>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.59-mm6
In-Reply-To: <5.1.1.6.2.20030127191904.00cc2508@pop.gmx.net>
Message-ID: <Pine.LNX.4.44.0301271414230.28141-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jan 2003, Mike Galbraith wrote:

> (something seems funky with nmi_watchdog... hard lock = no_more_nmi_ticks 
> .  Anybody out there know enough about local APIC to explain why idle=poll 
> gives nice 1 second nmi, but everything else depends upon cpu load?... and 
> why when hardlock happens, it _stops_)

Because we base the performance counter on unhalted cycles, whilst the 
normal idle function does an hlt. I think the K7 can do halted too.

	Zwane
-- 
function.linuxpower.ca

