Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284809AbSAGSL2>; Mon, 7 Jan 2002 13:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284728AbSAGSLT>; Mon, 7 Jan 2002 13:11:19 -0500
Received: from ns.suse.de ([213.95.15.193]:45586 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S284711AbSAGSLE>;
	Mon, 7 Jan 2002 13:11:04 -0500
Date: Mon, 7 Jan 2002 19:11:03 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Patrick Mochel <mochel@osdl.org>
Cc: Paul Jakma <paulj@alphyra.ie>, <knobi@knobisoft.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Hardware Inventory [was: Re: ISA slot detection on PCI systems?]
In-Reply-To: <Pine.LNX.4.33.0201070955480.867-100000@segfault.osdlab.org>
Message-ID: <Pine.LNX.4.33.0201071908580.16327-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jan 2002, Patrick Mochel wrote:

> One of the ideas that I've kicked around with some people here and the
> ACPI guys is the notion of trigger device enumeration from userspace
> completely.
>
> During the initramfs stage, a program (say devmgr) figures out what type
> of system you have, where the PCI buses are, etc. It tells the kernel this
> information, which then probes for existence, then loads drivers.

Sounds remarkably like the work that Greg has been doing with hotplug
support.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

