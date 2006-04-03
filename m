Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932280AbWDCEub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbWDCEub (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 00:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbWDCEub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 00:50:31 -0400
Received: from mail19.syd.optusnet.com.au ([211.29.132.200]:22661 "EHLO
	mail19.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932280AbWDCEua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 00:50:30 -0400
From: Con Kolivas <kernel@kolivas.org>
To: ck@vds.kolivas.org
Subject: Re: [ck] Re: lowmem_reserve question
Date: Mon, 3 Apr 2006 14:50:18 +1000
User-Agent: KMail/1.9.1
Cc: Mike Galbraith <efault@gmx.de>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <200604021401.13331.kernel@kolivas.org> <1144039366.8198.2.camel@homer> <200604031448.01391.kernel@kolivas.org>
In-Reply-To: <200604031448.01391.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604031450.19177.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 03 April 2006 14:48, Con Kolivas wrote:
> On Monday 03 April 2006 14:42, Mike Galbraith wrote:
> > On Mon, 2006-04-03 at 12:48 +1000, Con Kolivas wrote:
> > > Furthermore, now that we have the option of up to 3GB lowmem split on
> > > 32bit we can have a default lowmem_reserve of almost 12MB (if I'm
> > > reading it right) which seems very tight with only 16MB of ZONE_DMA.
> >
> > I haven't crawled around in the vm for ages, but I think that's only
> > 16MB if you support antique cards.
>
> That's what the ram is used for, but that is all the ZONE_DMA 32bit
> machines get

32bit i386 architecture I mean.

> , whether you use it for that purpose or not. My concern is 
> that this will have all sorts of effects on the balancing since it will
> always appear almost full.

Cheers,
Con
