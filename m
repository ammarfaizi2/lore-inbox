Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269677AbUICNEB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269677AbUICNEB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 09:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269674AbUICNEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 09:04:00 -0400
Received: from mailgate.urz.tu-dresden.de ([141.30.66.154]:63366 "EHLO
	mailgate.urz.tu-dresden.de") by vger.kernel.org with ESMTP
	id S269663AbUICNBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 09:01:45 -0400
Message-ID: <1094216504.41386b383000b@rmc60-231.urz.tu-dresden.de>
Date: Fri,  3 Sep 2004 15:01:44 +0200
From: Hendrik Fehr <s4248297@rcs.urz.tu-dresden.de>
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Full CPU-usage on sis5513-chipset disc input/output-operations
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2
X-Originating-IP: 217.238.206.14
X-TUD-Virus-Scanned: by amavisd-new at rks24.urz.tu-dresden.de
X-TUD-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on rks24
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson writes:
> [...]
> These are "received illegal vector" errors. They indicate
> a serious problem, either with the local APIC bus itself,
> or with how the ACPI/MP tables cause us to program the local
> and I/O APICs.
> 
> Do the errors persist if you disable ACPI?
> 
I just tried the following two things:
Boot option "acpi=off" (made the cusour switching faster on and off). And when
it came to ide setup i get lots of "hda lost interrupt". The system is
unbootable with that option.

With boot option "noapic" there are no more APIC error messages. Should i add
that boot option to my defaults in /etc/lilo.conf?
