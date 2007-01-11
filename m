Return-Path: <linux-kernel-owner+w=401wt.eu-S1751453AbXAKV3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbXAKV3h (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 16:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbXAKV3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 16:29:36 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:18873 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453AbXAKV3g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 16:29:36 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZP/XW1eiWZ5da2BZ58MJJeEzUR2w7cXOM59FrcJJl72uU0dE6WKWcWQBe3vU+W2sgfLsIjUKvdmWVipJQXN644tAB99RAcu3glnYX6gMZSEYR4rRRN5a8yWVmwHxmvH1JJgPsLG7owMldgkcezYV42myIyEexHu+jWU+R8SKENM=
Message-ID: <8355959a0701111329t506ba4e6g993400ea31d47b3e@mail.gmail.com>
Date: Fri, 12 Jan 2007 02:59:34 +0530
From: "Sunil Naidu" <akula2.shark@gmail.com>
To: "Stefan Richter" <stefanr@s5r6.in-berlin.de>
Subject: Re: Linux-2.6.20-rc4 - Kernel panic!
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <tkrat.113437f9eecab84a@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <8355959a0701110300j33d28f54y67728eb847c7ba31@mail.gmail.com>
	 <45A681E5.6060502@s5r6.in-berlin.de>
	 <8355959a0701111211m416e202bx637bca22f8fca826@mail.gmail.com>
	 <tkrat.113437f9eecab84a@s5r6.in-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/07, Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:
> Sunil Naidu wrote:
> > compiling a driver as module has same affect (while
> > loading/booting of kernel) compare to compiling a driver as kernel
> > builtin feature?
>
> LKML is not the place for such questions.

Being wexed from these problems, I didn't frame that question
properly. Okay, sorry for that.

I meant to ask choosing (from Xconfig tree)  a driver as module has
same affect compare to compiling a driver as kernel builtin feature?
(while loading/booting of kernel)

> Modules have to be loaded from a filesystem while built-in features are
> available from the start.
>
> The bootloader only loads the kernel image and optionally an initrd. The
> initrd is used as a preliminary root filesystem which may contain kernel
> modules to load to make the real root filesystem accessible. That's what
> distributors do because they don't know in advance which drivers their
> users will actually need. Endusers who build their own kernels might as
> well compile all drivers that are needed for access to the root
> filesystem into the kernel image and work without initrd.

The funda about the modules & bootloader I do know, thanks for explaining.
I did check the distro .config file (2.6.18-1.2868.fc6). Even I have
changed the my .config files according to the distro's. Even after
that, same error message.

Problem I think is choosing most of the drivers (allmost all) from the
Xconfig list? (even the one's I don't use/need). What do you suggest?

> --
> Stefan Richter
> -=====-=-=== ---= -=-==

~ Akula2
