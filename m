Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161103AbWFVMAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161103AbWFVMAS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 08:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161101AbWFVMAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 08:00:18 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:45358 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1161102AbWFVMAQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 08:00:16 -0400
Date: Thu, 22 Jun 2006 14:00:14 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Miller <davem@davemloft.net>,
       herbert@gondor.apana.org.au, snakebyte@gmx.de,
       linux-kernel@vger.kernel.org, jgarzik@pobox.com, netdev@vger.kernel.org
Subject: Re: Memory corruption in 8390.c ?
Message-ID: <20060622120014.GA13681@harddisk-recovery.com>
References: <20060622023029.GA6156@gondor.apana.org.au> <20060622.012609.25474139.davem@davemloft.net> <20060622083037.GB26083@gondor.apana.org.au> <20060622.013440.97293561.davem@davemloft.net> <1150976063.15275.146.camel@localhost.localdomain> <1150976016.3120.19.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1150976016.3120.19.camel@laptopd505.fenrus.org>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2006 at 01:33:36PM +0200, Arjan van de Ven wrote:
> On Thu, 2006-06-22 at 12:34 +0100, Alan Cox wrote:
> > The 8390 change (corrected version) also makes 8390.c faster so should
> > be applied anyway, 
> 
> 8390 is such a race monster that a few cycles matter a lot! :-)

It sure is. Back in the old days I could saturate a 10 Mbit ethernet
segment using a Western Digital 8003 (the 8 bit ISA card) in a 386DX40
(running Linux 1.0, 1.2, and 1.3).


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
