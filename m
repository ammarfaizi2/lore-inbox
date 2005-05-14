Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262735AbVENLGI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262735AbVENLGI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 07:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262736AbVENLGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 07:06:08 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:1810 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262735AbVENLGF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 07:06:05 -0400
Date: Sat, 14 May 2005 21:05:16 +1000
To: Manfred Schwarb <manfred99@gmx.ch>
Cc: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org,
       davem@redhat.com, netdev@oss.sgi.com
Subject: Re: 2.4.30-hf1 do_IRQ stack overflows
Message-ID: <20050514110516.GA1238@gondor.apana.org.au>
References: <E1DVyuq-0005Sf-00@gondolin.me.apana.org.au> <21780.1115887477@www69.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21780.1115887477@www69.gmx.net>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2005 at 10:44:37AM +0200, Manfred Schwarb wrote:
>
> Trace; f8b531fc <[reiserfs]reiserfs_insert_item+14c/150>
> Trace; c02387be <__kfree_skb+fe/160>
> Trace; c02387be <__kfree_skb+fe/160>
> Trace; f90dd5f4 <[8139too]rtl8139_start_xmit+84/180>

Do you have any funky netfilter/iptables modules loaded?
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
