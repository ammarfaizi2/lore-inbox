Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313401AbSDQJHV>; Wed, 17 Apr 2002 05:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313622AbSDQJHU>; Wed, 17 Apr 2002 05:07:20 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:33038 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313401AbSDQJHU>; Wed, 17 Apr 2002 05:07:20 -0400
Subject: Re: [PATCH] 2.5.8 IDE 36
To: dalecki@evision-ventures.com (Martin Dalecki)
Date: Wed, 17 Apr 2002 10:24:55 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds),
        david.lang@digitalinsight.com (David Lang),
        vojtech@suse.cz (Vojtech Pavlik),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <3CBD25E2.2050404@evision-ventures.com> from "Martin Dalecki" at Apr 17, 2002 09:36:02 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16xlgN-0001tP-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > A small number of other setups people wired the IDE the quick and easy
> > way and their native format is indeed ass backwards - some M68K disks and
> > the Tivo are examples of that. Interworking requires byteswapping and the
> > ability to handle byteswapped partition tables.
> 
> I said it already multiple times Alan - please note that the byte-swapping code
> for *physically* crosswired systems is *still there*. OK?

Thats not relevant to the discussion. I don't see why you brought it up. The
loopback stuff is about handling backward disks for interchange between 
systems or dealing with historical weirdnesses much more than physical layer
