Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316654AbSERDDZ>; Fri, 17 May 2002 23:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316657AbSERDDZ>; Fri, 17 May 2002 23:03:25 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:17426 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316654AbSERDDY>; Fri, 17 May 2002 23:03:24 -0400
Subject: Re: Question : Broadcast Inter Process Communication ?
To: jt@hpl.hp.com
Date: Sat, 18 May 2002 04:23:30 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Linux kernel mailing list)
In-Reply-To: <20020517195438.A30640@bougret.hpl.hp.com> from "Jean Tourrilhes" at May 17, 2002 07:54:38 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E178uoc-0007q4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	That's exactly why I don't want to deal with it myself.
> 	However, the kernel deal with it all the time, and do it
> well. For example RtNetlink event have this property (except that they
> are kernel => process instead of beeing process => process).

By sending one copy of the message to each target. Its how everyone does
it except for special cases. Reliable multi-delivery is -hard-
