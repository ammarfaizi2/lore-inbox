Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265230AbTAJPZD>; Fri, 10 Jan 2003 10:25:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265246AbTAJPYy>; Fri, 10 Jan 2003 10:24:54 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:48530
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265305AbTAJPYn>; Fri, 10 Jan 2003 10:24:43 -0500
Subject: Re: [PATCH] ne.c 8139too.c to fix CERT VU#412115, 2.4.20
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David McCullough <davidm@snapgear.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, becker@scyld.com,
       jgarzik@mandrakesoft.com
In-Reply-To: <20030111005234.A4803@beast.internal.moreton.com.au>
References: <20030111005234.A4803@beast.internal.moreton.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042215573.31848.6.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 10 Jan 2003 16:19:35 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-01-10 at 14:52, David McCullough wrote:
> Hi all,
> 
> Here's a patch for the ne2000 driver (ne.c) and the RealTek driver
> (8139too.c) in the 2.4.20 kernel to fix the CERT vulnerability VU#412115:
> 
> 	http://www.kb.cert.org/vuls/id/412115

See Marcelo pre tree and -ac tree. I think we have them all covered
between the -ac tree and Marcelo's BK stuff

> For interest,  the smc9194 and FEC ethernet drivers appear to be ok.
> Please CC me on any replies,

FEC I agree with. SMC9194 I believe needs fixing (and is fixed in the
-ac tree).

Alan

