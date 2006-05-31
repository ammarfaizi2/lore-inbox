Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965155AbWEaWDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965155AbWEaWDb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 18:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965198AbWEaWDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 18:03:31 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:23186 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S965155AbWEaWDa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 18:03:30 -0400
Date: Thu, 1 Jun 2006 00:03:27 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Keith Chew <keith.chew@gmail.com>
cc: Erik Mouw <erik@harddisk-recovery.com>, linux-kernel@vger.kernel.org
Subject: Re: IO APIC IRQ assignment
In-Reply-To: <20f65d530605300705l60bfcca7k47a41c95bf42a0ef@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0606010002200.30170@yvahk01.tjqt.qr>
References: <20f65d530605300521q1d56c3a3t84be3d92f1df0c14@mail.gmail.com> 
 <20060530135017.GD5151@harddisk-recovery.com>
 <20f65d530605300705l60bfcca7k47a41c95bf42a0ef@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 
>> Or the engineer means that in legacy PIC mode the IRQs are shared, but
>> in APIC mode they can be separated. That is a different thing, cause in
>> that case the IRQ lines are not physically connected, but put together
>> in PIC mode and can again be separated by using APIC mode.
>
> Ah, you could be right here. In the BIOS, there an option to
> enable/disable APIC, which corresponds to what you are suggesting
> above.
>
Plus
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y

but I guess you already have these.


Jan Engelhardt
-- 
