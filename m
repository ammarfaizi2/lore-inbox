Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262363AbVGZXio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262363AbVGZXio (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 19:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262332AbVGZXiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 19:38:25 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:16032 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S262354AbVGZXhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 19:37:41 -0400
From: Grant Coady <lkml@dodo.com.au>
To: Michel Bouissou <michel@bouissou.net>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       dbrownell@users.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [SOLVED ?] VIA KT400 + Kernel 2.6.12 + IO-APIC + ehci_hcd = IRQ trouble
Date: Wed, 27 Jul 2005 09:37:34 +1000
Organization: www.scatter.mine.nu
Reply-To: lkml@dodo.com.au
Message-ID: <8rhde15d7070a58v15t7eil02lvnvs516r@4ax.com>
References: <Pine.LNX.4.44L0.0507261450160.4914-100000@iolanthe.rowland.org> <200507262139.27150@totor.bouissou.net>
In-Reply-To: <200507262139.27150@totor.bouissou.net>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jul 2005 21:39:26 +0200, Michel Bouissou <michel@bouissou.net> wrote:
>
>Yes, but it doesn't tell us why kernels 2.4x felt perfectly happy with the old 
>BIOS...
You turned off 4k stacks?  I have a Via KM400 chipset box locked 
up a few times, once under 2.4.31-hf2 after 4.5 hours compiling 
kernels, fixed with some .config tuning.  Done 48+ hours continuous 
compiling kernels with 2.6.12.3 + 8k stacks, load ~2.2.  Just adding 
a datapoint...  Dunno if this relevant.  Simpler, older box with 
Intel 440BX chipset is happy with 4k stacks, only 2 USB ports.

Grant.

