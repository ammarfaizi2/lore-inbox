Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268158AbTAKVyB>; Sat, 11 Jan 2003 16:54:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268159AbTAKVyB>; Sat, 11 Jan 2003 16:54:01 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:19226
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S268158AbTAKVyA>; Sat, 11 Jan 2003 16:54:00 -0500
Date: Sat, 11 Jan 2003 17:01:42 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] cardbus/hotplugging still broken in 2.5.56
In-Reply-To: <200301111605.RAA06360@harpo.it.uu.se>
Message-ID: <Pine.LNX.4.44.0301111659230.2174-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yOn Sat, 11 Jan 2003, Mikael Pettersson wrote:

> Cardbus/hotplugging is still broken in 2.5.56. Inserting a
> card fails due a bogus 'resource conflict', and ejecting it
> oopses the kernel. It's been this way since 2.5.4x-something.
> 
> Dell Latitude, Texas PCI1131 cardbus bridge, 3c575_cb NIC.

I think its a matter of resource collisions only and the oops is 
inadequate cleanup on failure. I've tested cardbus/hotplugging on a TI PCI1211 and 
Tulip 21142 based NIC. Perhaps find the last working kernel?

	Zwane
-- 
function.linuxpower.ca

