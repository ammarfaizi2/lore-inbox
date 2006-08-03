Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030185AbWHCTC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030185AbWHCTC7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 15:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030196AbWHCTC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 15:02:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24449 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030182AbWHCTC5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 15:02:57 -0400
Date: Thu, 3 Aug 2006 14:59:27 -0400
From: Dave Jones <davej@redhat.com>
To: Christoph Hellwig <hch@infradead.org>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, davem@davemloft.net, linville@tuxdriver.com,
       jt@hpl.hp.com
Subject: Re: orinoco driver causes *lots* of lockdep spew
Message-ID: <20060803185927.GB11577@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Arjan van de Ven <arjan@infradead.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	davem@davemloft.net, linville@tuxdriver.com, jt@hpl.hp.com
References: <1154607380.2965.25.camel@laptopd505.fenrus.org> <E1G8der-0001fm-00@gondolin.me.apana.org.au> <20060803141153.GB20405@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060803141153.GB20405@infradead.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 03:11:53PM +0100, Christoph Hellwig wrote:

 > Could we please just get rid of the wireless extensions over netlink code
 > again?  It doesn't help to solve anything and just creates a bigger mess
 > to untangle when switching to a fully fledged wireless stack.

If we're going to do that, now is probably the best time to do it,
before any distro userland starts using it.

		Dave

-- 
http://www.codemonkey.org.uk
