Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261862AbSKCNRC>; Sun, 3 Nov 2002 08:17:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261866AbSKCNRB>; Sun, 3 Nov 2002 08:17:01 -0500
Received: from blackbird.intercode.com.au ([203.32.101.10]:51470 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S261862AbSKCNRB>; Sun, 3 Nov 2002 08:17:01 -0500
Date: Mon, 4 Nov 2002 00:22:39 +1100 (EST)
From: James Morris <jmorris@intercode.com.au>
To: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
cc: kisza@securityaudit.hu, <linux-kernel@vger.kernel.org>,
       <netdev@oss.sgi.com>, <netfilter-devel@lists.netfilter.org>,
       <davem@redhat.com>, <kuznet@ms2.inr.ac.ru>, <usagi@linux-ipv6.org>
Subject: Re: [PATCH] IPv6: Functions Clean-up
In-Reply-To: <20021103.221658.52523847.yoshfuji@linux-ipv6.org>
Message-ID: <Mutt.LNX.4.44.0211040019450.7526-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Nov 2002, YOSHIFUJI Hideaki / [iso-2022-jp] 吉藤英明 wrote:

> So, the reason why the copy of route6_me_harder() 
> lives there is because net/ipv6/ip6_output.c has not been 
> exported it.
> 

Yes.  It would be much better to use common core networking code.


- James
-- 
James Morris
<jmorris@intercode.com.au>


