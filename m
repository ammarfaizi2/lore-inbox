Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317236AbSEXSXt>; Fri, 24 May 2002 14:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317235AbSEXSXs>; Fri, 24 May 2002 14:23:48 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:40718 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S317234AbSEXSXr>; Fri, 24 May 2002 14:23:47 -0400
Subject: Re: It hurts when I shoot myself in the foot
To: kasperd@daimi.au.dk (Kasper Dupont)
Date: Fri, 24 May 2002 19:44:13 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Linux-Kernel)
In-Reply-To: <3CEE6CDC.D5D7FF9E@daimi.au.dk> from "Kasper Dupont" at May 24, 2002 06:39:56 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17BK2v-00074S-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > You can solve it by disabling pre-emption (and given its questionable
> > value doing so permanently might not be a bad idea).
> 
> Questionable value of what? TSC or preemption?

Pre-emption

> I wouldn't want to disable preemption during udelays.
> Either I would disable and enable preemption on every
> pass through the loop. Or I would just manually check

You've already made it too expensive too bother with

