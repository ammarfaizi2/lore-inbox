Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263379AbTC2EiJ>; Fri, 28 Mar 2003 23:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263380AbTC2EiJ>; Fri, 28 Mar 2003 23:38:09 -0500
Received: from ns.suse.de ([213.95.15.193]:26895 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S263379AbTC2EiI>;
	Fri, 28 Mar 2003 23:38:08 -0500
To: Dave Jones <davej@codemonkey.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NICs trading places ?
References: <20030328221037.GB25846@suse.de.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 29 Mar 2003 05:47:17 +0100
In-Reply-To: <20030328221037.GB25846@suse.de.suse.lists.linux.kernel>
Message-ID: <p73isu2zsmi.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@codemonkey.org.uk> writes:

> I just upgraded a box with 2 NICs in it to 2.5.66, and found
> that what was eth0 in 2.4 is now eth1, and vice versa.
> Is this phenomenon intentional ? documented ?

Just assign mac addresses to names and run nameif early in boot.

-Andi
