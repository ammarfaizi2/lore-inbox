Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311642AbSCXSGk>; Sun, 24 Mar 2002 13:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311721AbSCXSGY>; Sun, 24 Mar 2002 13:06:24 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:9744 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311709AbSCXSEp>; Sun, 24 Mar 2002 13:04:45 -0500
Subject: Re: [2.4.18] Security: Process-Killer if machine get's out of memory
To: roy@karlsbakk.net (Roy Sigurd Karlsbakk)
Date: Sun, 24 Mar 2002 18:20:58 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), andihartmann@freenet.de (andreas),
        linux-kernel@vger.kernel.org (Kernel-Mailingliste)
In-Reply-To: <Pine.LNX.4.30.0203241757520.30437-100000@mustard.heime.net> from "Roy Sigurd Karlsbakk" at Mar 24, 2002 05:59:38 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16pCby-0006t6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > away. My box doesn't OOM, the worst case (which I've never seen happen) is
> > a task being killed by a stack growth failing to get memory.
> 
> Would it hard to do some memory allocation statistics, so if some process
> at one point (as rsync did) goes crazy eating all memory, that would be
> detected?

man ulimit
