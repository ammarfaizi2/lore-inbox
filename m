Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292593AbSBZBZY>; Mon, 25 Feb 2002 20:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292604AbSBZBZP>; Mon, 25 Feb 2002 20:25:15 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:776 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292593AbSBZBYu>; Mon, 25 Feb 2002 20:24:50 -0500
Subject: Re: 2.4.19-preX: What we really need: -AA patches finally in the tree
To: brownfld@irridia.com (Ken Brownfield)
Date: Tue, 26 Feb 2002 01:39:23 +0000 (GMT)
Cc: Dieter.Nuetzel@hamburg.de (=?iso-8859-1?Q?Dieter_N=FCtzel?=),
        linux-kernel@vger.kernel.org (Linux Kernel List)
In-Reply-To: <20020225190241.C26077@asooo.flowerfire.com> from "Ken Brownfield" at Feb 25, 2002 07:02:41 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16fWaR-00077n-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> While I agree that -aa (or -rmap -- something to rescue the VM) should
> go in ASAP, applying O(1) is a little more questionable.  I've been
> applying O(1) for a while with great results, but it could be construed

I plan to put O(1) in the -ac tree to see how it works out

> that relied on previous behavior.  Kind of like that parent vs. child
> scheduling issue of a few months ago.  But I could be all wet on that.

For big boxes its fairly important to have O(1). For the new Intel Xeons
its very much more pressing because your box just doubled its notional
number of CPUs and the results with the old scheduler are deeply unfunny
