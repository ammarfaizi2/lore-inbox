Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262695AbTCPRRS>; Sun, 16 Mar 2003 12:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262699AbTCPRRS>; Sun, 16 Mar 2003 12:17:18 -0500
Received: from mail.skjellin.no ([80.239.42.67]:44726 "HELO mail.skjellin.no")
	by vger.kernel.org with SMTP id <S262695AbTCPRRR>;
	Sun, 16 Mar 2003 12:17:17 -0500
Subject: Re: problems with DFE-580TX (sundance) in 2.4.20
From: Andre Tomt <andre@tomt.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1047743481.7202.29.camel@slurv.ws.tomt.net>
References: <1047743481.7202.29.camel@slurv.ws.tomt.net>
Content-Type: text/plain; charset=ISO-8859-1
Organization: 
Message-Id: <1047835672.6970.12.camel@slurv.ws.tomt.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2- 
Date: 16 Mar 2003 18:27:53 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-15 at 16:51, Andre Tomt wrote: 
> Hi,
> 
> I recently got hold of a D-Link DFE-580TX 4 port Server Adapter for
> testing, but we're having serious issues with it. It is a card with a
> Intel PCI-to-PCI bridge on it, having 4 sundance chips on their "own"
> bus.

Seems like we solved it, maybe I should read the warnings on MMIO access
to the NIC registers in the kernel configuration next time - I'm a bit 
ashamed now :-)

I have no possibility to try other hardware setups and coldboots until
monday, but so far it seems to be working, over about 5 warm boots in
the Intel setup.

-- 
Mvh,
André Tomt
andre@tomt.net

