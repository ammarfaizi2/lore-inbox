Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261530AbSLPVeI>; Mon, 16 Dec 2002 16:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261723AbSLPVeI>; Mon, 16 Dec 2002 16:34:08 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:41183
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261530AbSLPVeH>; Mon, 16 Dec 2002 16:34:07 -0500
Subject: Re: i810 sound starts and stops for 2.4.XX and i845PE chipset
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: edward.kuns@rockwellfirstpoint.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <OFEC2D1079.106A6C04-ON86256C91.00739206-86256C91.0073544D@rockwellfirstpoin
	t.com>
References: <OFEC2D1079.106A6C04-ON86256C91.00739206-86256C91.0073544D@rockwellfirstpoin
	t.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 16 Dec 2002 22:21:42 +0000
Message-Id: <1040077302.13910.100.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-12-16 at 21:03, edward.kuns@rockwellfirstpoint.com wrote:
> Please CC me at edward.kuns at rockwellfirstpoint.com in your responses.
> 
> I have a Gigabyte GA-8PE667 Ultra motherboard (aka P4 Titan 667 Ultra) with
> the i845PE chipset.  According to the motherboard manual, it uses the
> Realtek ALC650 CODEC.

At a first guess it may be IRQ routing. If you build a kernel with
apic/local apic support does that work any better ?

