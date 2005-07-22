Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261391AbVGVTwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261391AbVGVTwg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 15:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262149AbVGVTwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 15:52:36 -0400
Received: from warden2-p.diginsite.com ([209.195.52.120]:20212 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S261391AbVGVTwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 15:52:34 -0400
From: David Lang <david.lang@digitalinsight.com>
To: christos gentsis <christos_gentsis@yahoo.co.uk>
Cc: linux-kernel@vger.kernel.org
X-X-Sender: dlang@dlang.diginsite.com
Date: Fri, 22 Jul 2005 12:52:22 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: kernel optimization
In-Reply-To: <42E14134.1040804@yahoo.co.uk>
Message-ID: <Pine.LNX.4.62.0507221250450.23492@qynat.qvtvafvgr.pbz>
References: <42E14134.1040804@yahoo.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a airly frequent question

the short answer is 'don't try'

the longer answer is that all the additional optimization options that are 
part of O3+ are considered individually and if they make sense for the 
kernel they are explicitly enabled (in some cases the optimizations need 
to be explicitly turned off for proper functionality of the kernel under 
all versions of GCC)

David Lang

On Fri, 22 Jul 2005, christos gentsis wrote:

> Date: Fri, 22 Jul 2005 19:55:48 +0100
> From: christos gentsis <christos_gentsis@yahoo.co.uk>
> To: linux-kernel@vger.kernel.org
> Subject: kernel optimization
> 
> hello
>
> i would like to ask if it possible to change the optimization of the kernel 
> from -O2 to -O3 :D, how can i do that? if i change it to the top level 
> Makefile does it change to all the Makefiles?
>
> And let's say that i change it... does this generate any problems with the 
> space that the kernel will take? (the kernel will be much larger)
>
> Thanks
> Chris
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
