Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267579AbUG3CVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267579AbUG3CVy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 22:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267582AbUG3CUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 22:20:50 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:18451 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S267579AbUG3CUp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 22:20:45 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: willy@w.ods.org (Willy Tarreau)
Subject: Re: PATCH: VLAN support for 3c59x/3c90x
Cc: greearb@candelatech.com, akpm@osdl.org, alan@redhat.com,
       jgarzik@redhat.com, linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <20040729041811.GF1545@alpha.home.local>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.26-1-686-smp (i686))
Message-Id: <E1BqN0L-0005dD-00@gondolin.me.apana.org.au>
Date: Fri, 30 Jul 2004 12:20:17 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau <willy@w.ods.org> wrote:
> 
> I noticed a bug in the 2.4 tulip driver concerning MTU. The parameter
> is correctly declared as a static int, initialized with default values,
> checked by the code, but not declared as MODULE_PARM, so the user cannot
> change it ! I wanted to send a patch but didn't find time to work on it
> yet. So if your vlan patch fixes it, it's welcome :-)

Why is this a module parameter at all? Can't you set it using ifconfig?
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
