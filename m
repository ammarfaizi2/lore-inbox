Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264236AbUGYQg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264236AbUGYQg0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 12:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264213AbUGYQg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 12:36:26 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:5349 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S264236AbUGYQfc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 12:35:32 -0400
Date: Sun, 25 Jul 2004 18:33:38 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Ferenc Kubinszky <ferenc.kubinszky@wit.mht.bme.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: via-velocity problem
Message-ID: <20040725183338.A27442@electric-eye.fr.zoreil.com>
References: <20040725002518.A14684@electric-eye.fr.zoreil.com> <Pine.LNX.4.44.0407251603190.23775-100000@wit.wit.mht.bme.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0407251603190.23775-100000@wit.wit.mht.bme.hu>; from ferenc.kubinszky@wit.mht.bme.hu on Sun, Jul 25, 2004 at 04:12:18PM +0200
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ferenc Kubinszky <ferenc.kubinszky@wit.mht.bme.hu> :
[...]
> I patched the kernel and copied the driver into 2.6.8-rc2.
> Now i does not hang the machine at all, but there is an other problem.

Did this problem exist when you used the modular form of the kernel that
you referred to in your previous message ?

> wget become stalled after ~100kbytes and tcpdump shows broken ip packets.
[...]
> I'm not sure where is the error, in my card, my cable modem or at the
> TV-NET provider.
> 
> With my e100 everithing OK.

Probably not beyond the card.

I'll welcome the ritual 'lspci -vx', 'lsmod', /proc/interrupts, ifconfig
output (before/after problem) and the complete dmesg from the boot until
the breakage happens.

--
Ueimor
