Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030301AbVIOAKq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030301AbVIOAKq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 20:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030302AbVIOAKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 20:10:45 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:59054 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1030301AbVIOAKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 20:10:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:From:Reply-To:To:Subject:Date:User-Agent:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=bGFDgkIxYl304GNnRb5KCUdauH8K9O9sYr2B6rX5Q70e3L0Rf9laMF+8pOcqP6BC40p9aU3MFN/jB1qOIgky2oWNPjCgaiSB9L2LVcfZYgyDlZyx6tLE6EfiJgh3CYmuIHL0BRU9Ohdgi4vKV+HhjwyBnzKFz1IgHFIMQTvY1WY=  ;
From: Marek W <marekw1977@yahoo.com.au>
Reply-To: marekw1977@yahoo.com.au
To: linux-kernel@vger.kernel.org
Subject: Re: Automatic Configuration of a Kernel
Date: Thu, 15 Sep 2005 10:09:59 +1000
User-Agent: KMail/1.8.2
References: <20050914223836.53814.qmail@web51011.mail.yahoo.com> <6bffcb0e05091415533d563c5a@mail.gmail.com> <4328B710.5080503@in.tum.de>
In-Reply-To: <4328B710.5080503@in.tum.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509151009.59981.marekw1977@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Sep 2005 09:49, Daniel Thaler wrote:
> Michal Piotrowski wrote:
> > Hi,
> >
> > On 15/09/05, Ahmad Reza Cheraghi <a_r_cheraghi@yahoo.com> wrote:
> >>Hi
> >>
> >>I wrote this Framework for making a .config based on
> >>the System Hardwares. It would be a great help if some
> >>people would give me their opinion about it.
> >>
> >>Regards
> >
> > It's for new linux users? They should use distributions kernels.
> > It's for "power users"? They just do make menuconfig...
> > It's for kernel developers? They just do vi .config.
>
> I like the idea.
> I'm a power user and of course I can do make menuconfig, but it would be
> useful when building a kernel for new hardware for example.
>
> Currently that involves looking at dmesg output to figure out the correct
> options; this would provide a nice base config to work with and reduce the
> amount of effort.

I second that. Unlike majority of users I suppose, I upgrade the kernel often 
and I am on the bleeding edge (laptop user with some drivers still being in 
development). Even with oldconfig it's easy to miss a useful driver 
(sometimes there's no help or the volume of new options is too large).

Something that can do the hardware detection, then maps that to drivers would 
be very useful.


--

Marek W
Send instant messages to your online friends http://au.messenger.yahoo.com 
