Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbVLOSJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbVLOSJg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 13:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbVLOSJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 13:09:36 -0500
Received: from nproxy.gmail.com ([64.233.182.206]:11287 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750778AbVLOSJf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 13:09:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YNtgVaTP0vc4z8wLdsYqSOTzF/2/eSLFTb3TBOXvSiGWPd2ayUjOWspnwU6yVhaov+hfUQw7XOZwxwh5UEsstCtNu8cFFD7rgy4VHaeqdpfmXsfznbpPD0K4XfqOwhf4TtPjxNViogRHm6IBCdyzAeZrBkgtExVLuiCZvwvPTEU=
Message-ID: <40f323d00512151009h5eece648w80882f0cda078507@mail.gmail.com>
Date: Thu, 15 Dec 2005 19:09:34 +0100
From: Benoit Boissinot <bboissin@gmail.com>
To: Martin Bligh <mbligh@mbligh.org>
Subject: Re: 2.6.15-rc5-mm3 (new build failure)
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <43A1A95D.10800@mbligh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43A1A95D.10800@mbligh.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/05, Martin Bligh <mbligh@mbligh.org> wrote:
> New build failure since -mm2:
> Config is
> http://ftp.kernel.org/pub/linux/kernel/people/mbligh/config/abat/elm3b67
>
> I'm guessing it was using gcc 2.95.4, though not sure.
>
>    CC      arch/i386/kernel/asm-offsets.s
> In file included from include/linux/stddef.h:4,
>                   from include/linux/posix_types.h:4,
>                   from include/linux/types.h:13,
>                   from include/linux/capability.h:16,
>                   from include/linux/sched.h:7,
>                   from arch/i386/kernel/asm-offsets.c:7:
> include/linux/compiler.h:46: #error Sorry, your compiler is too old/not
> recognized.

support for gcc-2.95 was dropped in -mm3.

regards,

Benoit
