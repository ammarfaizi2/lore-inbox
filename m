Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266780AbTGGAvQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 20:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266782AbTGGAvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 20:51:16 -0400
Received: from adicia.telenet-ops.be ([195.130.132.56]:1503 "EHLO
	adicia.telenet-ops.be") by vger.kernel.org with ESMTP
	id S266780AbTGGAvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 20:51:11 -0400
Date: Mon, 7 Jul 2003 03:08:04 +0200
From: Vincent Touquet <vincent.touquet@pandora.be>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, "Grover, Andrew" <andrew.grover@intel.com>
Subject: Re: [Bug report] System lockups on Tyan S2469 and lots of io [smp boot time problems too :(]
Message-ID: <20030707010804.GG4675@ns.mine.dnsalias.org>
Reply-To: vincent.touquet@pandora.be
References: <20030706210243.GA25645@lea.ulyssis.org> <20030707003007.GE4675@ns.mine.dnsalias.org> <20030706175232.470c4588.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030706175232.470c4588.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 06, 2003 at 05:52:32PM -0700, Andrew Morton wrote:
>Do 2.4 kernels boot both CPUs OK?  Do you use ACPI in 2.4?
The dmesg output shows both CPUs being put online.
/proc/cpuinfo lists both CPUs too

I don't use ACPI, even though I enabled it in the BIOS so I could use
acpismp=force (else the kernel finds no ACPI table of course).

I will see if disabling it in the BIOS helps, I will check it tomorrow
(I have to let the array be rebuilt anyway).

>The ACPI changes in 2.5 were recently merged into 2.4, so current
>2.4 may be broken for you too.

Hm, I don't want anything to do with ACPI actually :)
Anything that could give me a lock free smp machine with a working 3ware
card, would make me happy. 

I hope I don't have to wait for the 2.6 series to have a stable machine.

best regards,

Vincent
