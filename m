Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279930AbRJ3LwM>; Tue, 30 Oct 2001 06:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279934AbRJ3LwC>; Tue, 30 Oct 2001 06:52:02 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:3346 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279930AbRJ3Lvr>; Tue, 30 Oct 2001 06:51:47 -0500
Subject: Re: [BUG] Smbfs + preempt on 2.4.10
To: vda@port.imtp.ilyichevsk.odessa.ua (vda)
Date: Tue, 30 Oct 2001 11:57:38 +0000 (GMT)
Cc: rml@tech9.net (Robert Love), linux-kernel@vger.kernel.org
In-Reply-To: <01103013235202.00855@nemo> from "vda" at Oct 30, 2001 01:23:52 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15yXWU-0006EF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I can't find where that write() func ptr is coming
> (tracked it to tty->ldisc.write, but failed to find out
> where that field is assigned to).
> Somebody enlighten me...

For the vesa fb scrolling case you probably want to put your own scheduling
points into the vesafb copying
