Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266616AbUIMMlq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266616AbUIMMlq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 08:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266626AbUIMMlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 08:41:45 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:19385 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266616AbUIMMlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 08:41:44 -0400
Subject: Re: 2.6.9-rc1-mm4: r8169: irq 16: nobody cared!/TX Timeout
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: Sean Neakums <sneakums@zork.net>, jgarzik@pobox.com, akpm@osdl.org,
       netdev@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040912215933.GB27282@electric-eye.fr.zoreil.com>
References: <6upt4s4cro.fsf@zork.zork.net>
	 <20040912110614.GA20942@electric-eye.fr.zoreil.com>
	 <6u8ybf2w3f.fsf@zork.zork.net>
	 <20040912204319.GA27282@electric-eye.fr.zoreil.com>
	 <6uisaj19m4.fsf@zork.zork.net>
	 <20040912215933.GB27282@electric-eye.fr.zoreil.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095075479.14374.47.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 13 Sep 2004 12:38:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-09-12 at 22:59, Francois Romieu wrote:
> > Same result on starting X:
> > 
> > irq 16: nobody cared!
> 
> It slightly sounds like a broken irq routing.
> 
> Any taker for the hot potato ?

Try booting the -mm kernel with "irqpoll" as a boot option and see if it
survives but struggles. At least I think mm4 has the irqpoll hack in. If
so then you can work back and try and see whether things like acpi=off
work

