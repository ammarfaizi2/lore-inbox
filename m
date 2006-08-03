Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964870AbWHCTqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964870AbWHCTqe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 15:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964873AbWHCTqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 15:46:34 -0400
Received: from mga07.intel.com ([143.182.124.22]:15460 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S964870AbWHCTqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 15:46:33 -0400
X-IronPort-AV: i="4.07,209,1151910000"; 
   d="scan'208"; a="97016169:sNHT6908789384"
Message-ID: <44D25241.6040906@linux.intel.com>
Date: Thu, 03 Aug 2006 12:45:05 -0700
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: jt@hpl.hp.com
CC: Dave Jones <davej@redhat.com>, netdev@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       davem@davemloft.net, linville@tuxdriver.com
Subject: Re: orinoco driver causes *lots* of lockdep spew
References: <1154607380.2965.25.camel@laptopd505.fenrus.org> <E1G8der-0001fm-00@gondolin.me.apana.org.au> <20060803141153.GB20405@infradead.org> <20060803185800.GB12062@bougret.hpl.hp.com> <20060803185958.GC11577@redhat.com> <20060803194019.GA12152@bougret.hpl.hp.com>
In-Reply-To: <20060803194019.GA12152@bougret.hpl.hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Tourrilhes wrote:
> 	Jean
> 
> P.S. : By the way, don't ask me why it took four years for this bug to
> get discovered...

that I could answer: Only from 2.6.18-rc1 onwards does the kernel have a built in deadlock finder :)
