Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266651AbRGOPbO>; Sun, 15 Jul 2001 11:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266647AbRGOPbE>; Sun, 15 Jul 2001 11:31:04 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:55058 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S266651AbRGOPax>; Sun, 15 Jul 2001 11:30:53 -0400
Subject: Re: Linux 2.4.6-ac3
To: gareth.hughes@acm.org (Gareth Hughes)
Date: Sun, 15 Jul 2001 16:31:27 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B51A22F.16C6FEBB@acm.org> from "Gareth Hughes" at Jul 16, 2001 12:01:19 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Lnrk-00047x-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> the 3 parts are changed for the fun of it.  Granted, issues of backwards
> compatibility haven't been handled well in the past, but with the next
> resync I believe that moving forward this will no longer be a problem. 
> You'd have to talk to the guys at VA about this, however.

Right but we cannot go around breaking support for older setups. A user
updating their 2.4.x stable kernel and finding X11 no longer works simply isnt
an acceptable situation for serious users.

> Portability and maintainability were certainly two motivating factors in
> the move to a templated architecture for the core DRM.  I just got sick
> of seeing the same code in every driver -- kinda defeats the purpose of

Why was so much of it macroised rather than turned into library routines ?

> having a "core" DRM if it isn't being used...  New drivers are much
> easier to write as well, which is a nice side-effect.

That I can believe

Alan

