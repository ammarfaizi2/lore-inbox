Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268181AbTBNFdS>; Fri, 14 Feb 2003 00:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268183AbTBNFdS>; Fri, 14 Feb 2003 00:33:18 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:53775 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S268181AbTBNFdS>; Fri, 14 Feb 2003 00:33:18 -0500
Date: Fri, 14 Feb 2003 05:43:08 +0000
From: "'Christoph Hellwig '" <hch@infradead.org>
To: Osamu Tomita <tomita@cinet.co.jp>
Cc: "'Linux Kernel Mailing List '" <linux-kernel@vger.kernel.org>,
       "'Alan Cox '" <alan@lxorguk.ukuu.org.uk>,
       "'Jeff Garzik '" <jgarzik@pobox.com>
Subject: Re: [PATCHSET] PC-9800 subarch. support for 2.5.60 (13/34) NIC
Message-ID: <20030214054308.A18238@infradead.org>
Mail-Followup-To: 'Christoph Hellwig ' <hch@infradead.org>,
	Osamu Tomita <tomita@cinet.co.jp>,
	'Linux Kernel Mailing List ' <linux-kernel@vger.kernel.org>,
	'Alan Cox ' <alan@lxorguk.ukuu.org.uk>,
	'Jeff Garzik ' <jgarzik@pobox.com>
References: <E6D19EE98F00AB4DB465A44FCF3FA46903A333@ns.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E6D19EE98F00AB4DB465A44FCF3FA46903A333@ns.cinet.co.jp>; from tomita@cinet.co.jp on Fri, Feb 14, 2003 at 01:21:36PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2003 at 01:21:36PM +0900, Osamu Tomita wrote:
> #if deined(__ISAPNP__) && !defined(CONFIG_X86_PC9800)
> Each places are better?

Yes.

> PC98 has no EL3 PNP card, but has other PNP cards.

Does isapnp probing for EL3 cards actually causes any problems on
PC98?  If not I'd say just leave the code in.


