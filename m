Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265759AbSKOEkX>; Thu, 14 Nov 2002 23:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265770AbSKOEkX>; Thu, 14 Nov 2002 23:40:23 -0500
Received: from modemcable017.51-203-24.mtl.mc.videotron.ca ([24.203.51.17]:40458
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S265759AbSKOEkW>; Thu, 14 Nov 2002 23:40:22 -0500
Date: Thu, 14 Nov 2002 23:40:04 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Corey Minyard <cminyard@mvista.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
       "Heater, Daniel (IndSys, GEFanuc, VMIC)" <Daniel.Heater@gefanuc.com>,
       John Levon <levon@movementarian.org>,
       Dipankar Sarma <dipankar@gamebox.net>, <linux-kernel@vger.kernel.org>
Subject: Re: NMI handling rework for x86
In-Reply-To: <3DD47858.3060404@mvista.com>
Message-ID: <Pine.LNX.4.44.0211142338230.2750-100000@montezuma.mastecende.com>
X-Operating-System: Linux 2.4.19-pre5-ac3-zm4
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Nov 2002, Corey Minyard wrote:

> John Levon suggested I send this to you.  It's a cleanup of the NMI 
> handling to make it into a request/release mechanism (instead of 
> hard-coding everything into traps.c).  It renames "nmi.c" to 
> "nmi_watchdog.c" (as it should be named) and moves the real NMI handling 
> code from traps.c to nmi.c.  It's been posted and reworked on lkml, and 
> it seems to have finally met approval.  The "cc-ed" people have reviewed 
> the patch (or at least made helpful suggestions :-).

What interrupt rate have you tested this at? SMP? Adding handlers at 
runtime? I'm still skeptical on how RCU protects you, but i'm RCU clueless...

	Zwane
-- 
function.linuxpower.ca


