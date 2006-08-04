Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030291AbWHDCMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030291AbWHDCMM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 22:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030288AbWHDCMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 22:12:12 -0400
Received: from e-nvb.com ([69.27.17.200]:48005 "EHLO e-nvb.com")
	by vger.kernel.org with ESMTP id S1030289AbWHDCML (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 22:12:11 -0400
Subject: Re: orinoco driver causes *lots* of lockdep spew
From: Arjan van de Ven <arjan@infradead.org>
To: "John W. Linville" <linville@tuxdriver.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, davej@redhat.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       davem@davemloft.net, jt@hpl.hp.com
In-Reply-To: <20060803195306.GB7079@tuxdriver.com>
References: <1154607380.2965.25.camel@laptopd505.fenrus.org>
	 <E1G8der-0001fm-00@gondolin.me.apana.org.au>
	 <20060803195306.GB7079@tuxdriver.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Fri, 04 Aug 2006 04:11:03 +0200
Message-Id: <1154657483.2996.9.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-03 at 15:53 -0400, John W. Linville wrote:
> On Thu, Aug 03, 2006 at 11:54:41PM +1000, Herbert Xu wrote:
> Arjan, did you convince yourself whether or not this patch actually
> resolves the problem at hand?  Applying it makes sense to me either
> way, but it would be nice to believe it fixed a known issue. :-)

it'll fix a whole bunch of issues for sure, and this one as well afaics
(now with coffee ;-).. it probably won't fix all of them, but that's ok,
with this in place we actually CAN fix any others that pop up, right now
without this patch we probably can't.

> John
-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

