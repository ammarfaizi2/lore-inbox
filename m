Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbTLWP6i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 10:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbTLWP6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 10:58:38 -0500
Received: from CPEdeadbeef0000-CM000039d4cc6a.cpe.net.cable.rogers.com ([67.60.40.239]:23941
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id S261575AbTLWP6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 10:58:37 -0500
Date: Tue, 23 Dec 2003 10:59:30 -0500 (EST)
From: Shawn Starr <spstarr@sh0n.net>
To: scott.feldman@intel.com
cc: jgarzik@pobox.com, <linux-kernel@vger.kernel.org>
Subject: Re: [OOPS][2.6.0][e100 new driver] mii-diag oops with -F option
Message-ID: <Pine.LNX.4.44.0312231057410.836-100000@coredump.sh0n.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is correct, when I removed the __devinit's the oops did not occur.

I see this has been fixed in akpm's 2.6.0-mm1 release :-)

Thanks,

Shawn.

List:     linux-kernel
Subject:  RE: [OOPS][2.6.0][e100 new driver] mii-diag oops with -F option
Date:     2003-12-22 19:33:08

> New is a bit non-specific :)  What driver version?

It's got to be the e100-2.3.x driver in 2.6.0.

> If you remove all occurences of "__devinit", does the oops go away?

That's the problem.  __devinit's where there shouldn't be __devinit's.

So e100-3.0.x is pending in -exp queue for 2.6.1; do we fix 2.6.0?

-scott


