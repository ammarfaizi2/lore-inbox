Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265424AbSL2RqD>; Sun, 29 Dec 2002 12:46:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265506AbSL2RqD>; Sun, 29 Dec 2002 12:46:03 -0500
Received: from [81.2.122.30] ([81.2.122.30]:45829 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S265424AbSL2RqC>;
	Sun, 29 Dec 2002 12:46:02 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200212291754.gBTHs3Cd001525@darkstar.example.net>
Subject: Re: [2.5.53] So sloowwwww......
To: manfred@colorfullife.com (Manfred Spraul)
Date: Sun, 29 Dec 2002 17:54:03 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3E0F3545.4040601@colorfullife.com> from "Manfred Spraul" at Dec 29, 2002 06:47:49 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'd guess power management, a runaway interrupt, bad mtrr settings, 
> problems with the memory map decoding or Hyperthreading.
> 
> Check
> /proc/interrupts
> /proc/mtrr
> The memory detection results at the top of dmesg
> disable apm, acpi.
> Check anything Hyperthreading related in dmesg.

Also, toggle the APIC config settings.

John.
