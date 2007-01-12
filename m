Return-Path: <linux-kernel-owner+w=401wt.eu-S1161160AbXALXVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161160AbXALXVO (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 18:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161164AbXALXVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 18:21:14 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:38778 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161160AbXALXVN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 18:21:13 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bCk6sQ2+FT7H7lrhPIFcF+43CiRtHCqEvCxs1elUtg3v4O012yt7gF1tKLxXqL1ZgtQjTfivxhb9488YwvoJ0N4E3sySqWu4685sEKqgMatIcku6FbIuPVAQYIYptNUiMGKI9wUVcolqaHLtA120RzEW+d634OoIPtSvLWXs0bo=
Message-ID: <8355959a0701121521h47acde7cy5f4661bb283ae782@mail.gmail.com>
Date: Sat, 13 Jan 2007 04:51:11 +0530
From: "Sunil Naidu" <akula2.shark@gmail.com>
To: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Subject: Re: Choosing a HyperThreading/SMP/MultiCore kernel ?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20070112150349.GI17269@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <8355959a0701120525m5d1a7904i56b8a8f7316883d6@mail.gmail.com>
	 <20070112150349.GI17269@csclub.uwaterloo.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/07, Lennart Sorensen <lsorense@csclub.uwaterloo.ca> wrote:
>
> I would expect any distribution should work on these (as long as the
> kernel they use isn't too old.).  Of course if it is a Mac, you need a
> distribution that supports their firmware (which is of course not a PC
> bios).  As long as you can boot it, any i386 or amd64 kernel with smp
> enabled should use all the processors present (well amd64 on the
> core2duo and on the p4 if it is em64t enabled).

It is not a Mac here, IBM Workstation. I can see the Processor as
Pentium 4 CPU 3. GHz (family 15, model 4). How to know EM64T enabled,
any command?

Trying to understand, should I set CPUSETS=y and SCHED_MC=y Or ignore them.

> I believe the closest optimization for a Core2 is probably the Pentium M
> (certainly not the P4/netburst).  Not entirely sure though.
>

Yep, this ia a MacBookPro. I have decided about the distro. I did ask
this doubt when I got for the custom kernel compilation from source
after installation.

What I have seen in KConfig is, MPENTIUM4 used for the Xeon processor
too. I would try this soon on my Laptop (with SMP since it's a
Core2Duo). Anyway, shall post here.

> --
> Len Sorensen

Thanks,

~Sunil
