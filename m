Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316545AbSHSAGZ>; Sun, 18 Aug 2002 20:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316569AbSHSAGZ>; Sun, 18 Aug 2002 20:06:25 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:58544 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S316545AbSHSAGY>; Sun, 18 Aug 2002 20:06:24 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Scott Bronson <bronson@rinspin.com>
Cc: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>,
       linux-kernel@vger.kernel.org
Date: Sun, 18 Aug 2002 17:03:31 -0700 (PDT)
Subject: Re: IDE?  IDE-TNG driver
In-Reply-To: <1029630519.1541.11.camel@emma>
Message-ID: <Pine.LNX.4.44.0208181654290.18798-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A couple things in favor of a monlithic kernel.

there is a slight performance advantage becouse the calls don't
have to be far calls

there is a slight memory advantage becouse you don't have the fraction of
a page of ram lost per module

with a monolithic kernel there's no chance of making a mistake and trying
to use incompatable modules with your kernel (and before you say that this
can be fixed with the kernel build remember that for many people the build
machine is not where the kernel will be run)

David Lang


On 17 Aug 2002, Scott
Bronson wrote:

> Date: 17 Aug 2002 17:28:38 -0700
> From: Scott Bronson <bronson@rinspin.com>
> To: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: IDE?  IDE-TNG driver
>
> On Sat, 2002-08-17 at 15:57, Ruth Ivimey-Cook wrote:
> >  a) some people want basically module-less kernels
>
> Everyone I've heard advocating a moduleless kernel uses an argument that
> boils down to "it's slightly more secure."  Does anybody have a GOOD
> reason for not using modules?  Obsolete or embedded hardware arguments
> don't count.
>
>
> >  b) in some environments, you need to be able to select the IO mechanism
> >     without the ability to select the module to load.
>
> If that's the case, won't a kernel parameter suffice?  Can you
> elaborate?
>
>     - Scott
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
