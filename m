Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267393AbTBLOdq>; Wed, 12 Feb 2003 09:33:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267396AbTBLOdq>; Wed, 12 Feb 2003 09:33:46 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:15511 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S267393AbTBLOdo>; Wed, 12 Feb 2003 09:33:44 -0500
Date: Wed, 12 Feb 2003 15:37:14 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Dave Jones <davej@codemonkey.org.uk>,
       James McKenzie <james@fishsoup.dhs.org>,
       Christian Gennerat <christian.gennerat@polytechnique.org>,
       Martin Lucina <mato@kotelna.sk>,
       Paul Bristow <paul.bristow@technologist.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] rename all symbols in drivers/net/irda/donauboe.c
Message-ID: <20030212143714.GB18753@wohnheim.fh-wedel.de>
References: <20030212132313.GB22472@wohnheim.fh-wedel.de> <20030212134430.GB3770@codemonkey.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030212134430.GB3770@codemonkey.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 February 2003 13:44:30 +0000, Dave Jones wrote:
> 
> But with both drivers built into the kernel, it'll always default
> to the first one that gets initialised. There's a common
> PCI_DEVICE_ID_FIR701 in the pci_device_id tables of both drivers.
> 
> It sounds like these should be mutually exclusive when built-in.
> If you need a configuration with both, use modules.

Agreed.

Making them mutually exclusive should be next to impossible with the
2.4 config language, but it might make sense for 2.5. I will look into
it later.

Jörn

-- 
Correctness comes second.
Features come third.
Performance comes last.
Maintainability is needed for all of them.
