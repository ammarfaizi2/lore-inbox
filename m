Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265542AbUGOKxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265542AbUGOKxo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 06:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265678AbUGOKxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 06:53:44 -0400
Received: from smtp3.wanadoo.fr ([193.252.22.28]:32284 "EHLO
	mwinf0301.wanadoo.fr") by vger.kernel.org with ESMTP
	id S265542AbUGOKxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 06:53:42 -0400
Message-ID: <40F6623D.2030404@reolight.net>
Date: Thu, 15 Jul 2004 12:53:49 +0200
From: Auzanneau Gregory <greg@reolight.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: fr, fr-fr, en, en-gb, en-us
MIME-Version: 1.0
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8-rc1 and before: IO-APIC + DRI + RTL8139 = Disabling Ethernet
 IRQ
References: <40F4635C.3090003@reolight.net> <20040714013903.A21905@electric-eye.fr.zoreil.com> <40F4F8C1.6070900@reolight.net> <20040714224434.A3414@electric-eye.fr.zoreil.com>
In-Reply-To: <20040714224434.A3414@electric-eye.fr.zoreil.com>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Francois Romieu a écrit :
> Auzanneau Gregory <greg@reolight.net> :
> [...]
> 
>>This seems change nothing. So, as you requested, I join my complete
>>dmesg and lspci.
> 
> 
> [...]
> 
> Two more questions:
> - does the same kernel perform better if you append "acpi=off" on the
>   kernel boot command line ?

acpi works great, for correct use I append "noapic" on the kernel boot
command line.

> - is there a known latest working 2.6.x kernel with acpi enabled for your
>   hardware ?

I'me using acpi since 2.6.0-test3 without problem, but never test with
io-apic before because, it's the first time I need an SMP kernel.
(2.6.6 kernel of Knoppix 3.4 has the same problem on my computer)

> 
> (I assume you meant acpi instead of io-acpi in your former message ?)

I'm not sure, but I think acpi works fine.

Thank you all for the good work with linux, keep up with it !  :)

-- 
Auzanneau Grégory
GPG 0x99137BEE
