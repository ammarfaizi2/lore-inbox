Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285060AbSCCNcb>; Sun, 3 Mar 2002 08:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285352AbSCCNcV>; Sun, 3 Mar 2002 08:32:21 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:32522 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285060AbSCCNcL>; Sun, 3 Mar 2002 08:32:11 -0500
Subject: Re: 2.4.19-pre2-ac2 + preempt + lock-break
To: Dieter.Nuetzel@hamburg.de (Dieter =?iso-8859-15?q?N=FCtzel?=)
Date: Sun, 3 Mar 2002 13:46:23 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), rml@tech9.net (Robert Love),
        mingo@elte.hu (Ingo Molnar), andrea@suse.de (Andrea Arcangeli),
        linux-kernel@vger.kernel.org (Linux Kernel List),
        riel@conectiva.com.br
In-Reply-To: <200203030402.32814.Dieter.Nuetzel@hamburg.de> from "Dieter =?iso-8859-15?q?N=FCtzel?=" at Mar 03, 2002 04:02:32 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16hWJj-0004J0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> All OOM problems are fixed with vm_28 for me.

Excellent - thats one of the important ones.

> I've checked it with and without swap.
> With former versions some system tasks (smpppd), kdeinit and desktop processes 
> (xperfmon++, kpanel, kmail, kalarm, etc.) were falsely killed.

As an aside, with the address space accounting code Im testing we can finally
do precise OOM handling.

> With 2.4.19-pre2-ac2 + pre and without swap (I disabled it before running the 
> "test" prog) kswapd (?) goes into 20~25% system time usage and the whole 
> system gets unusable. I had to reboot...

I've not really done much testing without swap I must admit

Alan
