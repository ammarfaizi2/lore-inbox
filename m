Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313264AbSEESZP>; Sun, 5 May 2002 14:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313267AbSEESZO>; Sun, 5 May 2002 14:25:14 -0400
Received: from pc3-camc5-0-cust13.cam.cable.ntl.com ([80.4.125.13]:15745 "EHLO
	fenrus.demon.nl") by vger.kernel.org with ESMTP id <S313264AbSEESZN>;
	Sun, 5 May 2002 14:25:13 -0400
Date: Sun, 5 May 2002 19:21:49 +0100
Message-Id: <200205051821.g45ILnX02727@fenrus.demon.nl>
From: arjan@fenrus.demon.nl
To: R.E.Wolff@BitWizard.nl (Rogier Wolff)
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at page_alloc.c:82
In-Reply-To: <200205051706.TAA08782@cave.bitwizard.nl>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.9-31 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200205051706.TAA08782@cave.bitwizard.nl> you wrote:
> Christian [Borntr_ger] wrote:
>> Fabian Svara wrote:
>> > EIP:        0010:[<c0125183>]    Tainted: P
>> 
>> You have the Binary-NVIDIA Driver loaded, haven't you?
> 
> Would it be an idea to print the name of the module that (first)
> tainted the kernel here? That would eliminate this "guessing".

That would mean storing it in kernel memory and then people would object
to using kernel memory for that....

Anyway in this case there's no need.... this is a classic nvidia report;
just the same as all the other dozens.... I wonder what bug the latest
driver has to cause the exact same oops all over ;)
