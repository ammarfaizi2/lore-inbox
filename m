Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268323AbRHHTNL>; Wed, 8 Aug 2001 15:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268399AbRHHTNC>; Wed, 8 Aug 2001 15:13:02 -0400
Received: from [213.4.23.178] ([213.4.23.178]:7674 "HELO
	correo.interno.andago.com") by vger.kernel.org with SMTP
	id <S268323AbRHHTMp>; Wed, 8 Aug 2001 15:12:45 -0400
Date: Wed, 8 Aug 2001 00:51:55 +0200
From: Eric Van Buggenhaut <ericvb@debian.org>
To: Thierry Laronde <thierry@cri74.org>
Cc: Debian boot mailing list <debian-boot@lists.debian.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PCI] building PCI IDs/drivers DB from Linux kernel sources
Message-ID: <20010808005155.A831@femto.eric.ath.cx>
Reply-To: Eric.VanBuggenhaut@AdValvas.be
In-Reply-To: <20010730113319.A24939@pc04.cri.cur-archamps.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010730113319.A24939@pc04.cri.cur-archamps.fr>
User-Agent: Mutt/1.3.18i
X-Echelon: FBI CIA NSA Handgun Assault Atomic Bomb Heroin Drug Terrorism
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2001 at 11:33:19AM +0200, Thierry Laronde wrote:

[...]

> PROBLEMS
> --------
> 
> Macro definitions:
> 
> I have found two macros not defined anywhere (sorry, this is for 2.4.6; I
> haven't try for later):
> 
> PCI_DEVICE_ID_PHILIPS_SAA9730

Still not defined in 2.4.7 ...

> PCI_DEVICE_ID_V3_SEMI_V370PDC

defined in 2.4.7 in include/linux/mtd/pmc551.h:51

#ifndef PCI_DEVICE_ID_V3_SEMI_V370PDC
#define PCI_DEVICE_ID_V3_SEMI_V370PDC     0x0200
#endif

-- 
Eric VAN BUGGENHAUT

Eric.VanBuggenhaut@AdValvas.be
