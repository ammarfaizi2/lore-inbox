Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266648AbUIMMtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266648AbUIMMtD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 08:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266650AbUIMMtC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 08:49:02 -0400
Received: from zork.zork.net ([64.81.246.102]:11955 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S266648AbUIMMsu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 08:48:50 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Francois Romieu <romieu@fr.zoreil.com>, jgarzik@pobox.com, akpm@osdl.org,
       netdev@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc1-mm4: r8169: irq 16: nobody cared!/TX Timeout
References: <6upt4s4cro.fsf@zork.zork.net>
	<20040912110614.GA20942@electric-eye.fr.zoreil.com>
	<6u8ybf2w3f.fsf@zork.zork.net>
	<20040912204319.GA27282@electric-eye.fr.zoreil.com>
	<6uisaj19m4.fsf@zork.zork.net>
	<20040912215933.GB27282@electric-eye.fr.zoreil.com>
	<1095075479.14374.47.camel@localhost.localdomain>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Francois Romieu
	<romieu@fr.zoreil.com>, jgarzik@pobox.com, akpm@osdl.org,
	netdev@oss.sgi.com, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>
Date: Mon, 13 Sep 2004 13:48:35 +0100
In-Reply-To: <1095075479.14374.47.camel@localhost.localdomain> (Alan Cox's
	message of "Mon, 13 Sep 2004 12:38:01 +0100")
Message-ID: <6uoekaxrks.fsf@zork.zork.net>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: sneakums@zork.net
X-SA-Exim-Scanned: No (on zork.zork.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Sul, 2004-09-12 at 22:59, Francois Romieu wrote:
>> > Same result on starting X:
>> > 
>> > irq 16: nobody cared!
>> 
>> It slightly sounds like a broken irq routing.
>> 
>> Any taker for the hot potato ?
>
> Try booting the -mm kernel with "irqpoll" as a boot option and see if it
> survives but struggles. At least I think mm4 has the irqpoll hack in. If
> so then you can work back and try and see whether things like acpi=off
> work

Not sure if you caught the earlier context or if this is relevant, but
acpi=noirq does work.
