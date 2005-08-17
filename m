Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751221AbVHQTkQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbVHQTkQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 15:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbVHQTkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 15:40:16 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:43927 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751221AbVHQTkO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 15:40:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=aUWsPBiOFxAoNEhjnu9T7PDF/w+kXiVa9d6hmprXa3pGpxnT1epBltjku4BDpVZOzH8xNvyCDIWZO+xHNKqvb89c92wviCd9xgXycDsoZB4J5tQ+i/I2ymaXz9CsMWaDPZJcdPz9MjmlCWwAYlsYlgqt9vvLc8DBef5tvGyB6O0=
Date: Wed, 17 Aug 2005 23:48:47 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Adam Litke <agl@us.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Cleanup line-wrapping in pgtable.h
Message-ID: <20050817194847.GA26318@mipter.zuzino.mipt.ru>
References: <1124300739.3139.16.camel@localhost.localdomain> <20050817175601.GA19570@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050817175601.GA19570@infradead.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2005 at 06:56:01PM +0100, Christoph Hellwig wrote:
> > +static inline int pte_user(pte_t pte)
> > +	{ return (pte).pte_low & _PAGE_USER; }
> 
> Once you start reformatting things please make sure the result version
> matches the documented codingstyle.  That would be:
> 
> static inline int pte_user(pte_t pte)
> {
> 	return (pte).pte_low & _PAGE_USER;
	       ^   ^
> }
> 
> Quite a bit more verbose, but also a lot better readable.

Don't forget to drop "(" and ")".

