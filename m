Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278509AbRKVMiv>; Thu, 22 Nov 2001 07:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278584AbRKVMil>; Thu, 22 Nov 2001 07:38:41 -0500
Received: from carlsberg.amagerkollegiet.dk ([194.182.238.3]:11529 "HELO
	carlsberg.amagerkollegiet.dk") by vger.kernel.org with SMTP
	id <S278509AbRKVMii>; Thu, 22 Nov 2001 07:38:38 -0500
Date: Thu, 22 Nov 2001 13:38:37 +0100 (CET)
From: =?iso-8859-1?Q?Rasmus_B=F8g_Hansen?= <moffe@amagerkollegiet.dk>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: Pavel Machek <pavel@suse.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Disabling FPU, MMX, SSE units?
In-Reply-To: <Pine.GSO.3.96.1011122120030.29116A-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.LNX.4.33.0111221337530.1397-100000@grignard.amagerkollegiet.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Nov 2001, Maciej W. Rozycki wrote:

> On Wed, 21 Nov 2001, Pavel Machek wrote:
> 
> > Is there way not to let linux use FPU, MMX, SSE and similar fancy
> > units? I have athlon processor, but would like to turn FPU (and
> > similar fancy stuff) off...
> 
>  You may use "no387" to disable FPU and MMX (they are controlled by a
> single bit in cr0).  No idea about SSE.

Running a kernel optimized for 386 should leave out MMX, SSE and similar 
fancy instrucion sets IIRC.

Rasmus

-- 
-- [ Rasmus 'Møffe' Bøg Hansen ] ---------------------------------------
DISCLAIMER: Microsoft, Windows, Windows 98, Bugs, Lacking features, IRQ
conflicts, System crashes, Non-functional multitasking, the Y2K problem
and the Blue Screen of Death are registered trademarks of
Microsoft, Corp., Redmond, USA.
--------------------------------- [ moffe at amagerkollegiet dot dk ] --

