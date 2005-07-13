Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262817AbVGMVGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262817AbVGMVGJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 17:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262457AbVGMVGC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 17:06:02 -0400
Received: from smtp.osdl.org ([65.172.181.4]:225 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262798AbVGMVFt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 17:05:49 -0400
Date: Wed, 13 Jul 2005 14:06:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: linux-kernel@vger.kernel.org, ink@jurassic.park.msu.ru
Subject: Re: Bridge changes and lost console on 2.6.13-rc3
Message-Id: <20050713140644.16812c32.akpm@osdl.org>
In-Reply-To: <9e4733910507130952372a5bd@mail.gmail.com>
References: <9e4733910507130952372a5bd@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl <jonsmirl@gmail.com> wrote:
>
> During the boot process I lose my console. When X starts it is recoved. 
> 
> boot log .....
> PCI: Using ACPI for IRQ routing
> PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
> PCI: Bridge: 0000:00:01.0
>   IO window: d000-dfff
>   MEM window: fe900000-feafffff
>   PREFETCH window: f0000000-f7ffffff
> 
> >> console stops drawing here

Can you please do a `dmesg > foo', then compare that with the 2.6.13-rc2
dmesg output, send us a summary of what changed?
