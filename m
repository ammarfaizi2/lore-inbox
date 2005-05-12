Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261374AbVELJjs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261374AbVELJjs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 05:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbVELJjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 05:39:48 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:26127 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261374AbVELJjq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 05:39:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RSZj56LNx73al+uWBuCeyIxTf8eOtDcuqoPYOtTfpeg4MvRnPKF/GSsZKrQ4D81VwozCGv/s+HMETnmaSeBW8llVhFBtVj6ByAWnBiaSRlMFxYSRl6JeG9NAtH2i0eikY9lBKGae6k+0PMoev7CTYxs3TU7SddHFhntZQGjC1bI=
Message-ID: <b82a8917050512023938ce1f4d@mail.gmail.com>
Date: Thu, 12 May 2005 15:09:43 +0530
From: Niraj kumar <niraj17@gmail.com>
Reply-To: Niraj kumar <niraj17@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: NUMA aware slab allocator V2
Cc: Christoph Lameter <clameter@engr.sgi.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, shai@scalex86.org
In-Reply-To: <20050512000444.641f44a9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.58.0505110816020.22655@schroedinger.engr.sgi.com>
	 <20050512000444.641f44a9.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/05, Andrew Morton <akpm@osdl.org> wrote:
> Christoph Lameter <clameter@engr.sgi.com> wrote:
> >
> > This patch allows kmalloc_node to be as fast as kmalloc by introducing
> >  node specific page lists for partial, free and full slabs.
> 
> This patch causes the ppc64 G5 to lock up fairly early in boot.  It's
> pretty much a default config:
> http://www.zip.com.au/~akpm/linux/patches/stuff/config-pmac
> 
> No serial port, no debug environment, but no useful-looking error messages
> either.  See http://www.zip.com.au/~akpm/linux/patches/stuff/dsc02516.jpg

The image shows that kernel comand line option "quiet" was used .
We can probably get some more info if  booted without "quiet" .

Niraj
