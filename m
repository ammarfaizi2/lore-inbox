Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264547AbTGKRhC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 13:37:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264551AbTGKRhC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 13:37:02 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:19858 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S264547AbTGKRhA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 13:37:00 -0400
Date: Fri, 11 Jul 2003 19:51:41 +0200 (MEST)
Message-Id: <200307111751.h6BHpfse029581@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: daps_mls@libero.it
Subject: Re: 2.5 'what to expect'
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Jul 2003 17:59:39 +0200, Flameeyes <daps_mls@libero.it> wrote:
>On Fri, 2003-07-11 at 16:02, Dave Jones wrote:
>> - (Possibly linked to above bug) VIA APIC routing is currently broken.
>>   boot with 'noapic'.
>On my system (with VIA KT266 chipset) I can't boot also using noapic
>parameter, it freezes on "calibrating apic timer" using or not the
>noapic parameter.
>The only way is not enabling APIC at all.

Are you talking about UP_APIC or UP_IOAPIC?
Does UP_APIC with neither I/O-APIC nor ACPI work?
You could also try UP_IOAPIC but without ACPI.

/Mikael
