Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293341AbSCOVnN>; Fri, 15 Mar 2002 16:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293344AbSCOVnE>; Fri, 15 Mar 2002 16:43:04 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:12817 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293341AbSCOVmo>; Fri, 15 Mar 2002 16:42:44 -0500
Subject: Re: [PATCH] 2.4.18 scheduler bugs
To: mingo@elte.hu
Date: Fri, 15 Mar 2002 21:58:13 +0000 (GMT)
Cc: joe.korty@ccur.com (Joe Korty), marcelo@conectiva.com.br (Marcelo Tosatti),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0203152135170.22294-100000@elte.hu> from "Ingo Molnar" at Mar 15, 2002 09:35:49 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16lziH-0004ma-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > moment work for them becomes available.  I see no reason why an idle cpu
> > should be forced to remain idle until the next tick, nor why fixing that
> > should be considered `broken'.
> 
> performance. IPIs are expensive.

On a PIII I can see this being the case, especially as they dont power save
on hlt nowdays. But on the Athlon the IPI isnt going down a little side 
channel between cpus.

