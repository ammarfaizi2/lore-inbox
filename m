Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318509AbSGSMgr>; Fri, 19 Jul 2002 08:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318508AbSGSMgq>; Fri, 19 Jul 2002 08:36:46 -0400
Received: from chaos.analogic.com ([204.178.40.224]:1664 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S318505AbSGSMgN>; Fri, 19 Jul 2002 08:36:13 -0400
Date: Fri, 19 Jul 2002 08:39:07 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: venom@sns.it
cc: Robert Sinko <RSinko@island.com>,
       "'Hubbard, Dwight'" <DHubbard@midamerican.com>, Matt_Domsch@Dell.com,
       linux-kernel@vger.kernel.org
Subject: RE: Wrong CPU count
In-Reply-To: <Pine.LNX.4.43.0207191409110.18007-100000@cibs9.sns.it>
Message-ID: <Pine.LNX.3.95.1020719082245.159A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jul 2002 venom@sns.it wrote:

> 
> yes, as bios option.
> 
> On my point of view it would be interesting to verify is hyperthreading is
> really usefull or not.
> 

It would be interesting to determine if "hyperthreading" in the CPU 
actually exists. It may just be an artifact of dual instruction units,
actually a defect (perhaps harmless), that is hyped as a feature.

For instance, it has long been known that if a CPU were to have as
many instruction units as possible instruction branches, program
jumps upon logical conditions would not slow the machine down. The
hardware just continues using the instruction unit that contains the
correct program-flow while the others are re-loaded.

I guess that this is what is happening. After all, the processor only
has "so-many" connections to the outside world so it can't actually
function as two processors but, as Clinton said; "It depends upon what
is is..."

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

