Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbUFBJ60@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbUFBJ60 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 05:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbUFBJ60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 05:58:26 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:62994 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261451AbUFBJ6Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 05:58:25 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: agx@sigxcpu.org (Guido Guenther)
Subject: Re: [Patch]: Fix rivafb's OF parsing
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <20040601135335.GA5406@bogon.ms20.nix>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.25-1-686-smp (i686))
Message-Id: <E1BVSVR-0007xi-00@gondolin.me.apana.org.au>
Date: Wed, 02 Jun 2004 19:57:57 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guido Guenther <agx@sigxcpu.org> wrote:
>
> --- ../linux-2.6.7-rc2.orig/drivers/video/riva/fbdev.c  2004-05-30 11:40:32.000000000 -0300
> +++ drivers/video/riva/fbdev.c  2004-06-01 00:57:37.060599712 -0300
> @@ -1620,14 +1632,27 @@
>        struct riva_par *par = (struct riva_par *) info->par;
>        struct device_node *dp;
>        unsigned char *pedid = NULL;
> +        unsigned char *disptype = NULL;

Please use tabs instead of spaces.
-- 
Visit Openswan at http://www.openswan.org/
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
