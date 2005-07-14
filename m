Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261746AbVGNWQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbVGNWQE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 18:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbVGNWQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 18:16:04 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:41782 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261746AbVGNWPe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 18:15:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=k9QtDM9GvKQqbCkEpbmj5sEAmNjbRiOvtMLG3CAjn6hmgEwjAbvBrhgVIc5XnWWDbp7vvSnE9DPDCGLfsmykuCU8H+k7sndxWpQOMI6ixYHHcq6eS1GdgKKhSTVh1Miii5OFSdE/i5r9rPDdgDB1rxSqn45JwuZEyhWaUQ2A1oc=
Message-ID: <a4e6962a0507141515bb0b30f@mail.gmail.com>
Date: Thu, 14 Jul 2005 17:15:33 -0500
From: Eric Van Hensbergen <ericvh@gmail.com>
Reply-To: Eric Van Hensbergen <ericvh@gmail.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: (v9fs) -mm -> 2.6.13 merge status
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       rminnich@lanl.gov, linux-kernel@vger.kernel.org,
       v9fs-developer@lists.sourceforge.net
In-Reply-To: <200507150212.00515.adobriyan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050620235458.5b437274.akpm@osdl.org>
	 <a4e6962a050713112363010124@mail.gmail.com>
	 <20050714200408.GA23092@infradead.org>
	 <200507150212.00515.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/05, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> On Friday 15 July 2005 00:04, Christoph Hellwig wrote:
> > normally we prefer a patch per actual change, not per file so the
> > description fits.  Given that all these are pretty trivial fixes one
> > patch would have done it aswell, though.
> >
> > With these changes the code is fine for mainline in my opinion.
> 
> Can I make one more nitpicking comment?
> 
> All these functions can use cpu_to_le*() and le*_to_cpu().
> 

I need to rethink some parts of conv.c, I'll incorporate your
suggestion during the rework.  Thanks Alexey.

         -eric
