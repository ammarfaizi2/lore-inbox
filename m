Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316215AbSEQNdf>; Fri, 17 May 2002 09:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316216AbSEQNde>; Fri, 17 May 2002 09:33:34 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:29195 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316215AbSEQNdd>; Fri, 17 May 2002 09:33:33 -0400
Subject: Re: Aralion and IDE blasphemy
To: jpm@it-he.org (J.P. Morris)
Date: Fri, 17 May 2002 14:52:55 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (LKML)
In-Reply-To: <20020517142617.5b73a46d.jpm@it-he.org> from "J.P. Morris" at May 17, 2002 02:26:17 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E178iAB-0006Xu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is probably approaching blasphemy, but has anyone ever considered
> an emergency EIDE driver that uses the extended int13h calls?

Its not worth the pain. It was done by Adam J Richter before 1.0 in
fact and is long dead

> I'm pretty sure there's a protected-mode BIOS interface in modern BIOSes
> these days, so it shouldn't need to go down to real mode to make the
> calls.

Not a useful one

> The culprit is an ARALION ARS106S chipset card.  Interestingly it works
> in DOS, and if the hard disks are attached to it, it will even boot

What does lspci say the chipset really is ?

Alan
