Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264762AbTE1PPT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 11:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264764AbTE1PPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 11:15:19 -0400
Received: from franka.aracnet.com ([216.99.193.44]:48517 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S264762AbTE1PPS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 11:15:18 -0400
Date: Wed, 28 May 2003 08:28:09 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Dave Jones <davej@codemonkey.org.uk>, Roman Zippel <zippel@linux-m68k.org>,
       John Stoffel <stoffel@lucent.com>,
       DevilKin-LKML <devilkin-lkml@blindguardian.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.70 compile error
Message-ID: <15740000.1054135688@[10.10.2.4]>
In-Reply-To: <20030528074317.GE19818@holomorphy.com>
References: <200305271048.36495.devilkin-lkml@blindguardian.org> <20030527130515.GH8978@holomorphy.com> <200305271729.49047.devilkin-lkml@blindguardian.org> <20030527153619.GJ8978@holomorphy.com> <16083.35048.737099.575241@gargle.gargle.HOWL> <Pine.LNX.4.44.0305272010550.12110-100000@serv> <20030527184016.GA5847@suse.de> <4060000.1054072761@[10.10.2.4]> <20030528033459.GR8978@holomorphy.com> <13590000.1054102279@[10.10.2.4]> <20030528074317.GE19818@holomorphy.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> (1) APIC vs. xAPIC
> (2) clustered hierarchical DFR vs. flat DFR
> (3) physical DESTMOD vs. logical DESTMOD in IO-APIC RTE's
> (4) wakeup via INIT or via NMI
> (5) physical IPI's or logical IPI's
> 
> So one could easily form destinations by:

Yes. It's fixable, and I think that's a good project for 2.7, but I really
don't think that level of change is justified at the moment. Testing this
stuff is a pain in the ass, it's a lot of work to do properly and carefully.
And what does that change buy us in reality? Not a lot. 

I agree it would be nice to do ... just not the focus during a 2.6 
stabilisation effort, when we have so many other more important things to
work on, that would have real impact.

M.

