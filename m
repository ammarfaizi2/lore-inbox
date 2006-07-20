Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030371AbWGTUEX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030371AbWGTUEX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 16:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030373AbWGTUEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 16:04:23 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:29715 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1030371AbWGTUEX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 16:04:23 -0400
Date: Fri, 21 Jul 2006 06:04:13 +1000
To: Auke Kok <auke-jan.h.kok@intel.com>
Cc: Mark McLoughlin <markmc@redhat.com>, jesse.brandeburg@intel.com,
       linux-kernel@vger.kernel.org, xen-devel@lists.xensource.com
Subject: Re: e1000: Problem with "disable CRC stripping workaround" patch
Message-ID: <20060720200413.GA18715@gondor.apana.org.au>
References: <1153411868.2758.34.camel@localhost.localdomain> <44BFB288.5000105@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44BFB288.5000105@intel.com>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2006 at 09:42:48AM -0700, Auke Kok wrote:
>
> Please give it a try and let us know if it fixes the issue for you, it 
> should be much better than patching xen's code.

I don't really care on way or another whether we get the FCS.
However, the important thing to note here for Xen is that MTU
!= MRU.  Just because you've set the MTU to 1500 does not imply
that you won't receive packets > 1500.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
