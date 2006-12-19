Return-Path: <linux-kernel-owner+w=401wt.eu-S932700AbWLTAYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932700AbWLTAYI (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 19:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932661AbWLTAYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 19:24:07 -0500
Received: from rhun.apana.org.au ([64.62.148.172]:1736 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932700AbWLTAYF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 19:24:05 -0500
X-Greylist: delayed 1865 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Dec 2006 19:24:05 EST
From: Herbert Xu <herbert@gondor.apana.org.au>
To: shemminger@osdl.org (Stephen Hemminger)
Subject: Re: Bug 7596 - Potential performance bottleneck for Linxu TCP
Cc: mingo@elte.hu, akpm@osdl.org, wenji@fnal.gov, netdev@vger.kernel.org,
       davem@davemloft.net, linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <20061219103756.38f7426c@freekitty>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.17-rc4 (i686))
Message-Id: <E1Gwokt-00050T-00@gondolin.me.apana.org.au>
Date: Wed, 20 Dec 2006 10:52:19 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger <shemminger@osdl.org> wrote:
> I noticed this bit of discussion in tcp_recvmsg. It implies that a better
> queuing policy would be good. But it is confusing English (Alexey?) so
> not sure where to start.

Actually I think the comment says that the current code isn't the
most elegant but is more efficient.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
