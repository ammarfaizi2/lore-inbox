Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265686AbUABWgx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 17:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265691AbUABWgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 17:36:52 -0500
Received: from mail023.syd.optusnet.com.au ([211.29.132.101]:16870 "EHLO
	mail023.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265686AbUABWgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 17:36:50 -0500
Message-Id: <6.0.1.1.2.20040103091548.045ab3b8@mail.optusnet.com.au>
X-Nil: 
Date: Sat, 03 Jan 2004 09:36:40 +1100
To: ak@muc.de
From: Leon Toh <tltoh@attglobal.net>
Subject: Re: Adaptec/DPT I2O Option Omitted From Linux 2.6.0 Kernel
  Configuration Tool
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <m3n097hzvh.fsf@averell.firstfloor.org>
References: <19aKu-6Z-17@gated-at.bofh.it>
 <19aKu-6Z-19@gated-at.bofh.it>
 <19aKu-6Z-21@gated-at.bofh.it>
 <19aKu-6Z-23@gated-at.bofh.it>
 <19aKu-6Z-25@gated-at.bofh.it>
 <19aKu-6Z-15@gated-at.bofh.it>
 <19lcU-64y-19@gated-at.bofh.it>
 <m3n097hzvh.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 01:02 PM 2/01/2004, Andi Kleen wrote:
>Leon Toh <tltoh@attglobal.net> writes:
>
> > At this point of time I think fixing this driver for 32bit
> > architecture now is far more important than addressing 64bit
> > architecture, don't you agree Andi ?
>
>Unclear. The number of 2.4/AMD64 users tripping over this might
>be not much smaller than the number of early 2.6 adopter 32bit users.

Ok. So far I have not had anyone requesting for 64 bit Linux OS HBA 
support. However I'm getting more request for 2.6 32 bit support as they 
are starting development with it. Might be different in your part of world.

I'm not a programmer myself so I'm not sure how involved it would be to 
tidy the driver up. If it's only a couple of additional lines than it can 
be address at the same time. But if that's not the case than I think 
Adaptec should tidy up the 32 bit support before working on 64 bit support. 
Last I want to see is a complete buggy driver release due to a complete 
rewrite of the driver for 32 and 64 bit support.

- Leon 

