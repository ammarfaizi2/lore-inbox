Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311618AbSCNN1B>; Thu, 14 Mar 2002 08:27:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311616AbSCNN0v>; Thu, 14 Mar 2002 08:26:51 -0500
Received: from naxos.pdb.sbs.de ([192.109.3.5]:49603 "EHLO naxos.pdb.sbs.de")
	by vger.kernel.org with ESMTP id <S311618AbSCNN0p>;
	Thu, 14 Mar 2002 08:26:45 -0500
Date: Thu, 14 Mar 2002 14:29:38 +0100 (CET)
From: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Severe IRQ problems on Foster (P4 Xeon) system
In-Reply-To: <Pine.LNX.4.33.0203132006310.28859-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0203141426200.1477-100000@biker.pdb.fsc.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2002, Ingo Molnar wrote:

> let me know whether this fixes your problem,

The patch distributes the IRQs nicely between CPUs, but unfortunately does
not fix our timer IRQ problem.

Btw is it correct that one could also use the APIC Task Priority Registers
to implement "fair" IRQ routing? (If linux adjusted them, which it
currently doesn't).

Thanks & regards,
Martin

-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1	    mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy





