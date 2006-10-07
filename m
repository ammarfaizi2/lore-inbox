Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932508AbWJGR7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932508AbWJGR7f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 13:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932511AbWJGR7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 13:59:35 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:3435 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP id S932508AbWJGR7e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 13:59:34 -0400
Date: Sat, 7 Oct 2006 19:59:26 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Rajesh Shah <rajesh.shah@intel.com>, Andi Kleen <ak@muc.de>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "Luck, Tony" <tony.luck@intel.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Badari Pulavarty <pbadari@gmail.com>
Subject: Re: 2.6.19-rc1 genirq causes either boot hang or "do_IRQ: cannot handle IRQ -1"
Message-ID: <20061007175926.GN14186@rhun.haifa.ibm.com>
References: <20061005212216.GA10912@rhun.haifa.ibm.com> <m11wpl328i.fsf@ebiederm.dsl.xmission.com> <20061006155021.GE14186@rhun.haifa.ibm.com> <m1d5951gm7.fsf@ebiederm.dsl.xmission.com> <20061006202324.GJ14186@rhun.haifa.ibm.com> <m1y7rtxb7z.fsf@ebiederm.dsl.xmission.com> <20061007080315.GM14186@rhun.haifa.ibm.com> <m14pugxe47.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m14pugxe47.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 07, 2006 at 10:52:24AM -0600, Eric W. Biederman wrote:

> Can you try CONFIG_CPU_HOTPLUG?  That will force genapic to be set
> to genapic_physflat instead of genapic_flat.

Yep, it boots with CONFIG_CPU_HOTPLUG!

> If genapic_physflat works we will have to decide what to do about
> genapic_flat.

I'm happy to test any follow-on patches to make it work without
CONFIG_CPU_HOTPLUG.

Cheers,
Muli
