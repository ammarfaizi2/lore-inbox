Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264154AbUGHP0c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264154AbUGHP0c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 11:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263972AbUGHP0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 11:26:31 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:58629 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S263831AbUGHP0X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 11:26:23 -0400
Date: Fri, 9 Jul 2004 01:25:43 +1000
To: Kari Hurtta <hurtta+zz1@leija.mh.fmi.fi>
Cc: Michael Buesch <mbuesch@freenet.de>,
       Martin Zwickel <martin.zwickel@technotrend.de>, root@chaos.analogic.com,
       Chris Wright <chrisw@osdl.org>, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, sds@epoch.ncsc.mil, jmorris@redhat.com,
       mika@osdl.org
Subject: Re: [OT] NULL versus 0 (Re: [PATCH] Use NULL instead of integer 0 in security/selinux/)
Message-ID: <20040708152543.GA5057@gondor.apana.org.au>
References: <200407081442.25752.mbuesch@freenet.de> <200407081257.i68Cvm0U020579@leija.fmi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407081257.i68Cvm0U020579@leija.fmi.fi>
User-Agent: Mutt/1.5.6+20040523i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2004 at 03:57:48PM +0300, Kari Hurtta wrote:
> 
> As far I know it does not work on C when it is
> used as  argument of function and function
> have not prototype or function's prototype have ...

In that case NULL is wrong anyway since not all pointers are equivalent.
You need to cast 0 or NULL to the exact pointer type required by that
function.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
