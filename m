Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262312AbVBXMiw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262312AbVBXMiw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 07:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262326AbVBXMiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 07:38:52 -0500
Received: from alog0252.analogic.com ([208.224.222.28]:2944 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262312AbVBXMiC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 07:38:02 -0500
Date: Thu, 24 Feb 2005 07:37:03 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Alan Kilian <kilian@bobodyne.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Help enabling PCI interrupts on Dell/SMP and Sun/SMP systems.
In-Reply-To: <1109197066.9116.319.camel@desk>
Message-ID: <Pine.LNX.4.61.0502240733080.12742@chaos.analogic.com>
References: <1109190273.9116.307.camel@desk>  <Pine.LNX.4.61.0502231538230.5623@chaos.analogic.com>
 <1109197066.9116.319.camel@desk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Where are you getting IRQ5 from? You can't "hard-code" interrupts on
PCI.

> 	kernel: ACPI: PCI interrupt 0000:13:03.0[A] -> GSI 36 (level, low) ->
> IRQ 217
^^^^^^^^^___________ This is your IRQ

It should be in dev->irq AFTER it's enabled.
[SNIPPED...]


Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
