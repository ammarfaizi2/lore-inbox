Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313199AbSEHMAR>; Wed, 8 May 2002 08:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313314AbSEHMAQ>; Wed, 8 May 2002 08:00:16 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:43789 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313199AbSEHMAP>; Wed, 8 May 2002 08:00:15 -0400
Subject: Re: [PATCH] 2.5.14 IDE 56
To: dalecki@evision-ventures.com (Martin Dalecki)
Date: Wed, 8 May 2002 13:18:47 +0100 (BST)
Cc: torvalds@transmeta.com (Linus Torvalds),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        padraig@antefacto.com (Padraig Brady),
        aia21@cantab.net (Anton Altaparmakov),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <3CD8DAA2.6080907@evision-ventures.com> from "Martin Dalecki" at May 08, 2002 09:58:26 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E175QP9-0001RO-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> RedHat even disables all this chip set specific reporting in theyr
> public kernels. OK kudzu is using it, but it does not *rely on it*.

The boot kernel has a lot of it disabled not the main ones.

> Heck kudzu is running all the time I rebooted my system during
> developement and nothing ugly did happen.

I can't speak directly for the Kudzu maintainer but I can say that having
a sane way to obtain the list of ide devices (all of them not just non 
pcmcia) and the device bindings/type has been a long standing request.

If 2.6 breaks a 2.4 installer and nothing else I don't think its a big 
disaster and the cleanup may well be justified
