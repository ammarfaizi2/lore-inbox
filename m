Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbUG0Jnc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbUG0Jnc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 05:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbUG0Jnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 05:43:32 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:33799 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262062AbUG0Jna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 05:43:30 -0400
Date: Tue, 27 Jul 2004 10:43:11 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, Greg KH <greg@kroah.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] Add kref_read and kref_put_last primitives
Message-ID: <20040727104311.A18503@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ravikiran G Thirumalai <kiran@in.ibm.com>, Greg KH <greg@kroah.com>,
	akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20040726144856.GH1231@obelix.in.ibm.com> <20040726173151.A11637@infradead.org> <20040727070915.GC1270@obelix.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040727070915.GC1270@obelix.in.ibm.com>; from kiran@in.ibm.com on Tue, Jul 27, 2004 at 12:39:15PM +0530
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2004 at 12:39:15PM +0530, Ravikiran G Thirumalai wrote:
> struct kref does just that.  The kref api are just abstractions for 
> refcounting which i presume is recommended for all refcounters in the
> kernel.  I am just converting the struct file.f_count refcounter
> to use kref with this patch.  

So what exactly does the API make easier?  APIs for the APIs sense don't
make much sense.

