Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136059AbRDVMQq>; Sun, 22 Apr 2001 08:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136061AbRDVMQd>; Sun, 22 Apr 2001 08:16:33 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:29967 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136059AbRDVMQZ>; Sun, 22 Apr 2001 08:16:25 -0400
Subject: Re: 2.4.3+ sound distortion
To: marcel@mesa.nl
Date: Sun, 22 Apr 2001 13:17:31 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        v.p.p.julien@let.rug.nl (Victor Julien), linux-kernel@vger.kernel.org
In-Reply-To: <20010422095538.A16395@joshua.mesa.nl> from "Marcel J.E. Mol" at Apr 22, 2001 09:55:38 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14rIo2-0005hi-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I noticed that X11 became teribly slow on screen updates using 2.4.3-ac11 on
> an asus a7v133 (via686b).
> Before that I ran an a7v (via686a): using ac6 worked
> fine with X. X on ac9 also works fine, at least I did not notice any slowdown.
> Unfortunately cannot test ac11 on the a7v anymore...
> 
> I thought ac9 does include the via workarounds.  Is there a significant
> diff between ac9 and ac11, or between via686a and 686b to cause this?

We are still playing with the VIA fixups, but this may also be VM related. I'm
currently playing with several VM ideas, and potential fixes which might
impact overall performance.

Test 2.4.4pre6 that has the VIA fixes but does not have the VM changes

