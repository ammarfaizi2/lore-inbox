Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262527AbVCVH5k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262527AbVCVH5k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 02:57:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262528AbVCVH5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 02:57:39 -0500
Received: from gleb.nbase.co.il ([194.90.136.56]:31883 "EHLO gleb.nbase.co.il")
	by vger.kernel.org with ESMTP id S262527AbVCVH5C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 02:57:02 -0500
Date: Tue, 22 Mar 2005 09:56:58 +0200
From: Gleb Natapov <gleb@minantech.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Hayim Shaul <hayim@post.tau.ac.il>, linux-kernel@vger.kernel.org
Subject: Re: mmap/munmap bug
Message-ID: <20050322075658.GA32445@minantech.com>
References: <Pine.LNX.4.61.0503211731430.9160@nova.cs.tau.ac.il> <1111430042.6952.70.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111430042.6952.70.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2005 at 07:34:02PM +0100, Arjan van de Ven wrote:
> On Mon, 2005-03-21 at 17:32 +0200, Hayim Shaul wrote:
> > Hi all,
> > 
> > I have an unexplained bug with mmap/munmap on 2.6.X.
> > 
> > I'm writing a kernel module that gives super-fast access to the network.
> > It does so by doing mmap thus avoiding the memcpy to/from user.
> 
> well... you are aware the network stack already supports generic zero
> copy networking, right ?
> 
Does it support zero copy not only for send but also for receive? Can we
receive packets directly to userspace buffers?

--
			Gleb.
