Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbTHTJyH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 05:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261878AbTHTJyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 05:54:06 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:51095 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261877AbTHTJyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 05:54:05 -0400
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: Andi Kleen <ak@colin2.muc.de>, dang@fprintf.net, ak@muc.de, lmb@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030819122847.2d7e2e31.davem@redhat.com>
References: <mdtk.Zy.1@gated-at.bofh.it> <mgUv.3Wb.39@gated-at.bofh.it>
	 <mgUv.3Wb.37@gated-at.bofh.it> <miMw.5yo.31@gated-at.bofh.it>
	 <m365ktxz3k.fsf@averell.firstfloor.org>
	 <1061320620.3744.16.camel@athena.fprintf.net>
	 <20030819192125.GD92576@colin2.muc.de>
	 <1061321268.3744.20.camel@athena.fprintf.net>
	 <20030819193235.GG92576@colin2.muc.de>
	 <20030819122847.2d7e2e31.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061373200.32594.7.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 20 Aug 2003 10:53:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-08-19 at 20:28, David S. Miller wrote:
> Andi, we take the source address from the packet we are
> trying to send out that interface.
> 
> Just as it is going to be legal to send out a packet from
> that interface using that source address, it is legal to
> send out an ARP request from that interface using that source
> address.

Legal yes, but it can get you into holes with asymettric routing.

