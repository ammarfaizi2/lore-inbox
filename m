Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263002AbVALCKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263002AbVALCKh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 21:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263004AbVALCKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 21:10:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:43912 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263002AbVALCKc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 21:10:32 -0500
Date: Tue, 11 Jan 2005 18:10:31 -0800
From: Chris Wright <chrisw@osdl.org>
To: Andi Kleen <ak@muc.de>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: node_online_map patch kills x86_64
Message-ID: <20050111181030.F24171@build.pdx.osdl.net>
References: <20050111151656.A24171@build.pdx.osdl.net> <m1d5wb4jni.fsf@muc.de> <20050111163025.T469@build.pdx.osdl.net> <20050112013805.GA74675@muc.de> <20050111175313.E24171@build.pdx.osdl.net> <20050112020023.GB74675@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050112020023.GB74675@muc.de>; from ak@muc.de on Wed, Jan 12, 2005 at 03:00:23AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andi Kleen (ak@muc.de) wrote:
> > SRAT: PXM 0 -> APIC 0 -> Node 1
> > SRAT: PXM 1 -> APIC 1 -> Node 2
> > SRAT: Node 1 PXM 0 0-9ffff
> > SRAT: Node 1 PXM 0 0-3fffffff
> > SRAT: Node 2 PXM 1 40000000-7fffffff
> > Bootmem setup node 1 0000000000000000-000000003fffffff
> > Bootmem setup node 2 0000000040000000-000000007ff5ffff
> > No mptable found.
> > PANIC: early exception rip ffffffff8078b2e3 error 0 cr2 17c497a67
> 
> Can you please test if this patch fixes the problem? 

Yes it does.  Thanks Andi.
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
