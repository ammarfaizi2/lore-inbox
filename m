Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313727AbSDPP6d>; Tue, 16 Apr 2002 11:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313731AbSDPP6d>; Tue, 16 Apr 2002 11:58:33 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:41221 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313727AbSDPP6c>; Tue, 16 Apr 2002 11:58:32 -0400
Subject: Re: [PATCH] 2.5.8 IDE 36
To: torvalds@transmeta.com (Linus Torvalds)
Date: Tue, 16 Apr 2002 17:15:49 +0100 (BST)
Cc: vojtech@suse.cz (Vojtech Pavlik),
        dalecki@evision-ventures.com (Martin Dalecki),
        rgooch@ras.ucalgary.ca (Richard Gooch),
        david.lang@digitalinsight.com (David Lang),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <Pine.LNX.4.33.0204160844090.1167-100000@penguin.transmeta.com> from "Linus Torvalds" at Apr 16, 2002 08:46:31 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16xVcT-0000H9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Please use a the network block device, and teach the ndb deamon to just 
> byteswap each word.

You need to use loop not nbd - loopback nbd can deadlock. Byteswap as a 
new revolutionary crypto system for the loopback driver isnt hard

Alan
