Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263837AbTEOFwj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 01:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263845AbTEOFwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 01:52:39 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:55824 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S263837AbTEOFwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 01:52:37 -0400
Date: Thu, 15 May 2003 16:04:54 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Jouni Malinen <jkmaline@cc.hut.fi>
cc: Jeff Garzik <jgarzik@pobox.com>, Dave Jones <davej@codemonkey.org.uk>,
       <jt@hpl.hp.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>,
       David Gibson <hermes@gibson.dropbear.id.au>,
       Benjamin Reed <breed@almaden.ibm.com>,
       Javier Achirica <achirica@ttd.net>
Subject: Re: CryptoAPI and WEP/stream ciphers (was: airo and firmware upload)
In-Reply-To: <20030515042143.GA1918@jm.kir.nu>
Message-ID: <Mutt.LNX.4.44.0305151601120.12417-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 May 2003, Jouni Malinen wrote:

> I tried to change my WEP implementation to use CryptoAPI, but that ended
> up in problems.. If I understood correctly, current CryptoAPI supports
> only block ciphers(?).

Block ciphers and digests.

> certainly does not sound very reasonable.. Another alternative would be
> to add support for stream ciphers into CryptoAPI.

Yes, it would be good to have API support for stream encryption in 
general, e.g. also for OFB and Counter Mode.

> Do you think that it would still be required to get rid of the own WEP
> implementation in the Host AP driver before including it into the kernel
> tree? Would this mean that someone would first need to add support for
> stream ciphers into CryptoAPI? Any change of that happening for Linux
> 2.6.x?

I'd like to see it go in if the code is available.

> And one more question before using more time with WEP implementation..
> Is someone already working with stream cipher support for CryptoAPI?

Not that I know of.


- James
-- 
James Morris
<jmorris@intercode.com.au>

