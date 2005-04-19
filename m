Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261648AbVDSUVD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbVDSUVD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 16:21:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261655AbVDSUVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 16:21:03 -0400
Received: from coderock.org ([193.77.147.115]:63386 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261648AbVDSUUt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 16:20:49 -0400
Date: Tue, 19 Apr 2005 22:20:38 +0200
From: Domen Puncer <domen@coderock.org>
To: "YOSHIFUJI Hideaki / ?$B5HF#1QL@" <yoshfuji@linux-ipv6.org>
Cc: vda@port.imtp.ilyichevsk.odessa.ua, linux-kernel@vger.kernel.org,
       mpm@selenic.com
Subject: Re: [PATCH] introduce generic 64bit rotations and i386 asm optimized version
Message-ID: <20050419202037.GE21272@nd47.coderock.org>
References: <200504190918.10279.vda@port.imtp.ilyichevsk.odessa.ua> <20050419.154642.111848378.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050419.154642.111848378.yoshfuji@linux-ipv6.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/05 15:46 +0900, YOSHIFUJI Hideaki / ?$B5HF#1QL@ wrote:
> In article <200504190918.10279.vda@port.imtp.ilyichevsk.odessa.ua> (at Tue, 19 Apr 2005 09:18:10 +0300), Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> says:
> 
> > diff -urpN 2.6.12-rc2.1.be/include/linux/bitops.h 2.6.12-rc2.2.ror/include/linux/bitops.h
> > --- 2.6.12-rc2.1.be/include/linux/bitops.h	Mon Apr 18 22:55:10 2005
> > +++ 2.6.12-rc2.2.ror/include/linux/bitops.h	Tue Apr 19 00:25:28 2005
...
> > -static __inline__ int get_bitmask_order(unsigned int count)
> > +static inline int get_bitmask_order(unsigned int count)
> >  {
> >  	int order;
> >  	
> 
> Please keep using __inline__, not inline.

Why?

Couldn't find any threads about this, and even SubmittingPatches has:
"'static inline' is preferred over 'static __inline__'..."


	Domen
