Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316953AbSF0TvV>; Thu, 27 Jun 2002 15:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316954AbSF0TvV>; Thu, 27 Jun 2002 15:51:21 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:4791 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316953AbSF0TvU>;
	Thu, 27 Jun 2002 15:51:20 -0400
Date: Thu, 27 Jun 2002 12:53:32 -0700 (PDT)
From: Nivedita Singhvi <niv@us.ibm.com>
X-X-Sender: <nivedita@w-nivedita2.des.beaverton.ibm.com>
To: <hurwitz@lanl.gov>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: zero-copy networking & a performance drop
Message-ID: <Pine.LNX.4.33.0206271248260.13115-100000@w-nivedita2.des.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Now, here is my direct question: has a zero-copy TCP stack 
> been introduced after 2.4.3 (which we're running)? I believe 
> the answer is yes, but I've not been able to find direct confirmation. 
> If the answer is yes, does anything special need to be done 
> (in terms of allocating/working with skbs, or passing the packets 
> up to higher levels) in order to use the zero-copy implementation.

Yes, 2.4.4.  You should upgrade to that if possible, or rather,
a much more recent version..

That said, rx has been slower than sends in most of our testing
too. 


thanks,
Nivedita


