Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313006AbSDCBBn>; Tue, 2 Apr 2002 20:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313004AbSDCBBY>; Tue, 2 Apr 2002 20:01:24 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:32271 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312995AbSDCBBQ>; Tue, 2 Apr 2002 20:01:16 -0500
Subject: Re: Update on Promise 100TX2 + Serverworks IDE issues -- 2.2.20
To: xyzzy@speakeasy.org (Trent Piepho)
Date: Wed, 3 Apr 2002 02:18:15 +0100 (BST)
Cc: jim@rubylane.com, linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
In-Reply-To: <Pine.LNX.4.04.10204021623420.5141-100000@xyzzy.dsl.speakeasy.net> from "Trent Piepho" at Apr 02, 2002 04:48:49 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16sZPj-0002vm-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think the serverworks IDE is only mode4, not even UDMA33.  I heard a lot of
> bad things about it, and removed all the IDE drives from our serverworks
> system's controller.

Serverworks OSB4 IDE will do UDMA33 but seems to have problems with certain
combinations of drives, controllers and unknown influences. The newer CSB5 
seems to work beautifully

