Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263208AbTECBCI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 21:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263220AbTECBCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 21:02:08 -0400
Received: from c16812.rivrw3.nsw.optusnet.com.au ([211.28.63.178]:48905 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S263208AbTECBCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 21:02:08 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: akpm@digeo.com (Andrew Morton), linux-kernel@vger.kernel.org
Subject: Re: 2.5.68-mm4
In-Reply-To: <20030502133405.57207c48.akpm@digeo.com>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.5.17-20030301 ("Bubbles") (UNIX) (Linux/2.4.20-1-686-smp (i686))
Message-Id: <E19Blbe-00051K-00@gondolin.me.apana.org.au>
Date: Sat, 03 May 2003 11:14:26 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> wrote:
> 
> Are you using eepro100 or e100?  I found that e100 failed to bring up the
> interface on restart ("failed selftest"), but eepro100 was OK.

That's because the e100 driver puts the card into state D3 when shutting
down but can't get it back to D0 afterwards.

Please send info about your chipset to Intel so they can work this out.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
