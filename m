Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264096AbUEMLMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264096AbUEMLMN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 07:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264098AbUEMLMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 07:12:13 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:42769 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264096AbUEMLMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 07:12:09 -0400
Date: Thu, 13 May 2004 12:12:06 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm2
Message-ID: <20040513121206.A8620@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040513032736.40651f8e.akpm@osdl.org> <20040513114520.A8442@infradead.org> <20040513035134.2e9013ea.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040513035134.2e9013ea.akpm@osdl.org>; from akpm@osdl.org on Thu, May 13, 2004 at 03:51:34AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2004 at 03:51:34AM -0700, Andrew Morton wrote:
> Once I'm convinced that kernel.org kernels will be able to run applications
> which vendor kernels will run, sure.
> 
> We're nowhere near that, and your continual whining gets us no closer.

Sorry, but this argumentation is utter bullshit.

If $VENDORKERNEL/freebsd/sco/windows2000 runs $APP and we don't, what
does this mean?  Right, exactly nothing.  Follwoing that path of argumentation
we could also merge the almost 1000 patches from SuSE's tree because you
can be pretty sure some IHV or ISV relies on it.

I've talked to three persons at Oracle and neither likes it at all, in
fact en Oracle employee is working on doing quota for hugetlbfs which
fixes this properly.  Merging some horrible hacks that completly change
the authorization model (for a special case, that is) in the middle of
stable series doesn't get us anywhere, except into a horrible unmaintable
mess.
