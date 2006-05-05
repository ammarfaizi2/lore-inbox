Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbWEEO0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbWEEO0N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 10:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751557AbWEEO0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 10:26:13 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:35644 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751124AbWEEO0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 10:26:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=JTND3OIYpr8xaBJXjm1nY8belh+n5fPio5hQWaTpj6WhrNHH474APwBa/tKLJ19OSek48BPLbgMAIgz1UxKOfgR49h9iZYx5V065tPxrWOZr8oqKNG3fab2o/bOAgPb8pcUKMJeIaxwuSkd/cC5MhQhqcjzbfSP4WGzUKZfBmwc=
Message-ID: <445B610A.7020009@gmail.com>
Date: Fri, 05 May 2006 17:28:26 +0300
From: Alon Bar-Lev <alon.barlev@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Barry K. Nathan" <barryn@pobox.com>, Adrian Bunk <bunk@fs.tum.de>,
       Riley@Williams.Name, tony.luck@intel.com, johninsd@san.rr.com
Subject: Re: [PATCH][TAKE 4] THE LINUX/I386 BOOT PROTOCOL - Breaking the 256
 limit
References: <445B5524.2090001@gmail.com> <445B5C92.5070401@zytor.com>
In-Reply-To: <445B5C92.5070401@zytor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Alon Bar-Lev wrote:
>>
>>> Revert "x86_64/i386: increase command line size" patch
>>> It's a bootup dependancy, you can't just increase it
>>> randomly, and it breaks booting with LILO.
>>> Pointed out by Janos Farkas and Adrian Bunk.
>>
> 
> Can we get the details, please, instead of a repeat of the same patch,
> so we can figure out a proper solution?
> 
>     -hpa
> 

Hello Peter,

I don't know any other way to get the details. I am truly
thank you for your responses. But the people that rejected
this patch gave no detailed reason! I've extended the CC
list this time in a hope that someone will reply.

I also specify the exact history for this issue... In order
to encourage relevant people to reply.

This should be a simple modification and I don't see why we
should fight on the LILO problem (if exists) when we have
the compile time config options alternative.

People who uses LILO may leave the default 256 value. Other
may migrate to a higher one.

I also don't understand why every architecture have a
different command line size... The compile time config
option may solve all this to a unified solution with
different default for every architecture.

I will be glad to learn of a better to push this matter
forward, without adding a LILO specific code into the
kernel, which I don't think is wise... I prefer to continue
patching my and others kernel and not mess up kernel with
LILO specific code.

If you think I should stop this effort, please say so... I
will drop it.

Best Regards,
Alon Bar-Lev.

