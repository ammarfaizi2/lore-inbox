Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272322AbTGYVMA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 17:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272334AbTGYVId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 17:08:33 -0400
Received: from CPE0080c6f1c7c1-CM014160001801.cpe.net.cable.rogers.com ([24.101.63.200]:32480
	"EHLO muon.jukie.net") by vger.kernel.org with ESMTP
	id S272355AbTGYVHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 17:07:00 -0400
Date: Fri, 25 Jul 2003 17:24:05 -0400
From: Bart Trojanowski <bart@jukie.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.6-test1, PCMCIA cards require two insertions
Message-ID: <20030725212405.GE4743@jukie.net>
References: <20030725210242.GH15537@iarc.uaf.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030725210242.GH15537@iarc.uaf.edu>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Christopher Swingley <cswingle@iarc.uaf.edu> [030725 17:12]:
> I'm running 2.6.0-test1 on an SiS based laptop with all the PCMCIA 
> network and serial drivers built into the kernel.  When the system boots 
> with a PCMCIA cardbus card in place, the card doesn't show up.  I unplug 
> the card and plug it back in, and then the kernel "sees" it and it 
> works.  If I unplug it again, I have to go through a plug - unplug - 
> plug cycle before it recognizes it.  As if it only recognizes the card 
> on even numbered insertion events.

I see the same on my Thinkpad (CardBus bridge: Texas Instruments PCI1450)
With any card I've tried.  In addition on APM h/w suspend (ACPI didn't
work for me) I see the same thing... I have to pull out the card and put
it back in for it to be recognized.

Bart.

-- 
				WebSig: http://www.jukie.net/~bart/sig/
