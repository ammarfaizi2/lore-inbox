Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964904AbWFTCLi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964904AbWFTCLi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 22:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964903AbWFTCLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 22:11:38 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:6404 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S964859AbWFTCLh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 22:11:37 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: harry@atmos.washington.edu (Harry Edmon)
Subject: Re: Network performance degradation from 2.6.11.12 to 2.6.16.20
Cc: shemminger@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Organization: Core
In-Reply-To: <4496ACA6.7090305@atmos.washington.edu>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.17-rc4 (i686))
Message-Id: <E1FsViB-0006Qq-00@gondolin.me.apana.org.au>
Date: Tue, 20 Jun 2006 12:11:27 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Harry Edmon <harry@atmos.washington.edu> wrote:
> 
> That did not help.  I have 1 minute outputs from tcpdump under both 2.6.11.12 
> and 2.6.16.20.  You will see a large size difference between the files.  Since 
> the 2.6.11.12 one is 2 MBytes, I thought I would post them via the web instead 
> of via attachments.   Look at:
> 
> http://www.atmos.washington.edu/~harry/linux/2.6.11.12.out.1min
> http://www.atmos.washington.edu/~harry/linux/2.6.16.20.out.1min

The latter shows that it took 40ms to generate an ACK.  What does
'vmstat 1' show while this is happneing?
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
