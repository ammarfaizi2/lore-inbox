Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316886AbSFGRhE>; Fri, 7 Jun 2002 13:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317263AbSFGRhE>; Fri, 7 Jun 2002 13:37:04 -0400
Received: from postfix2-1.free.fr ([213.228.0.9]:4301 "EHLO postfix2-1.free.fr")
	by vger.kernel.org with ESMTP id <S316886AbSFGRhD>;
	Fri, 7 Jun 2002 13:37:03 -0400
Message-Id: <200206070538.g575c4r23497@colombe.home.perso>
Date: Fri, 7 Jun 2002 07:38:01 +0200 (CEST)
From: fchabaud@free.fr
Reply-To: fchabaud@free.fr
Subject: Re: [patch] i386 "General Options" - begone [take 2]
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1023232572.11340.10.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le  5 Jui, Alan Cox a écrit :
> 
> Power Management using
> 	CPU idling instructions
> 	APM
> 	Direct power management
> 	ACPI

I agree with you that direct power management should be made possible,
because there's nothing preventing a very old i386 without any APM nor
ACPI feature in BIOS to suspend correctly on disk. By the way, in such a
case APM or APCI just disable themselves aren't they ? So IMHO swsusp
should have its own /proc way to activate but that may raise conflict
issues with ACPI states.

--
Florent Chabaud

