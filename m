Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbTHSTTl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 15:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261185AbTHSTS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 15:18:27 -0400
Received: from relay.pair.com ([209.68.1.20]:13579 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S261274AbTHSTRE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 15:17:04 -0400
X-pair-Authenticated: 68.40.145.213
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
From: Daniel Gryniewicz <dang@fprintf.net>
To: Andi Kleen <ak@muc.de>
Cc: Lars Marowsky-Bree <lmb@suse.de>, davem@redhat.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <m365ktxz3k.fsf@averell.firstfloor.org>
References: <mdtk.Zy.1@gated-at.bofh.it> <mgUv.3Wb.39@gated-at.bofh.it>
	 <mgUv.3Wb.37@gated-at.bofh.it> <miMw.5yo.31@gated-at.bofh.it>
	 <m365ktxz3k.fsf@averell.firstfloor.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061320620.3744.16.camel@athena.fprintf.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 19 Aug 2003 15:17:00 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-08-19 at 14:48, Andi Kleen wrote:
> In my experience everybody who wants a different behaviour use some
> more or less broken stateful L2/L3 switching hacks (like ipvs) or
> having broken routing tables. While such hacks may be valid for some
> uses they should not impact the default case.

So, changing your default route is a "hack"?  That's all that's
necessary.  You can even do it with "route del/route add".
-- 
Daniel Gryniewicz <dang@fprintf.net>
