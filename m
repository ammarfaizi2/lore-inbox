Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292854AbSCFBQS>; Tue, 5 Mar 2002 20:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292858AbSCFBQI>; Tue, 5 Mar 2002 20:16:08 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:57867 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292854AbSCFBP5>; Tue, 5 Mar 2002 20:15:57 -0500
Subject: Re: [RFC] Arch option to touch newly allocated pages
To: jdike@karaya.com (Jeff Dike)
Date: Wed, 6 Mar 2002 01:30:19 +0000 (GMT)
Cc: hpa@zytor.com (H. Peter Anvin), bcrl@redhat.com (Benjamin LaHaise),
        alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <200203051812.NAA03363@ccure.karaya.com> from "Jeff Dike" at Mar 05, 2002 01:12:19 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16iQG3-000578-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> maximum memory exceeding the available tmpfs as long as they don't all need
> all that memory at once.  And, if they do, the patch I just posted will let
> them deal fairly sanely with the situation.

And the address space management stuff in the -ac tree will do all that and
more without force allocating pages and regardless of what other apps do
including without allowing your rude app to kill them.

You are using an axe to batter down a door. Worse than that I fitted a
perfectly good door handle.
