Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262833AbTCQIJ1>; Mon, 17 Mar 2003 03:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262834AbTCQIJ1>; Mon, 17 Mar 2003 03:09:27 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:48680
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S262833AbTCQIJ1>; Mon, 17 Mar 2003 03:09:27 -0500
Date: Mon, 17 Mar 2003 03:15:48 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>, Mark Haverkamp <markh@osdl.org>
Subject: Re: [Lse-tech] [PATCH][ANNOUNCE] 32way/8quad NUMAQ booting with 16
 IOAPICs, 223 IRQs
In-Reply-To: <20030317074149.GO5891@holomorphy.com>
Message-ID: <Pine.LNX.4.50.0303170311130.2229-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0303071148150.18716-100000@montezuma.mastecende.com>
 <20030317055415.GM5891@holomorphy.com> <Pine.LNX.4.50.0303170107560.2229-100000@montezuma.mastecende.com>
 <20030317062838.GN5891@holomorphy.com> <Pine.LNX.4.50.0303170226180.2229-100000@montezuma.mastecende.com>
 <20030317074149.GO5891@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Mar 2003, William Lee Irwin III wrote:

> On Mon, Mar 17, 2003 at 02:28:26AM -0500, Zwane Mwaikambo wrote:
> > I'd have to rob a couple more poor souls to get 16 quads ;)
> 
> Getting them together in one place involves extreme pain/hassles.

I managed to get some ethernet cards going note eth3/irq211 and 
eth2/irq163 these are on nodes 4 and 3 respectively.

http://www.osdl.org/projects/numaqhwspprt/results/interrupts

requesting vector for node4/irq211
returning new allocation node4/irq211 -> vector0xc1
irq_setup: node4/bus9/ioapic8/vector0xc1 - irq211 c010b6bc
09:0b.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)

requesting vector for node3/irq163
returning new allocation node3/irq163 -> vector0xc1
irq_setup: node3/bus7/ioapic6/vector0xc1 - irq163 c010b588
07:0b.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)


-- 
function.linuxpower.ca
