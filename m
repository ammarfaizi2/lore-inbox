Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292571AbSCDR1T>; Mon, 4 Mar 2002 12:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292560AbSCDR1O>; Mon, 4 Mar 2002 12:27:14 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:38919 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292571AbSCDR00>; Mon, 4 Mar 2002 12:26:26 -0500
Subject: Re: Raising an disabled tasklet / VC/KBD initialization bug.
To: ak@suse.de (Andi Kleen)
Date: Mon, 4 Mar 2002 17:41:27 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020304175603.A17963@wotan.suse.de> from "Andi Kleen" at Mar 04, 2002 05:56:03 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16hwSl-0008PO-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> of disabled tasklets properly or make sure kbd_init and vc_init have defined
> init order and the first always executes before the second. 
> 
> Comments? 

Oh this explains several non x86 reports. Yes We need to fix the link order
