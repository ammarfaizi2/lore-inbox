Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273790AbRIRAYR>; Mon, 17 Sep 2001 20:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273794AbRIRAYL>; Mon, 17 Sep 2001 20:24:11 -0400
Received: from smtp8.us.dell.com ([143.166.224.234]:30476 "EHLO
	smtp8.us.dell.com") by vger.kernel.org with ESMTP
	id <S273790AbRIRAX5>; Mon, 17 Sep 2001 20:23:57 -0400
Date: Mon, 17 Sep 2001 19:24:20 -0500 (CDT)
From: Robert Macaulay <robert_macaulay@dell.com>
X-X-Sender: <robert@ping.us.dell.com>
Reply-To: Robert Macaulay <robert_macaulay@dell.com>
To: Erik Andersen <andersen@codepoet.org>
cc: Colonel <klink@clouddancer.com>, <linux-kernel@vger.kernel.org>
Subject: RE: /proc/partitions hosed in 2.4.9-ac10
In-Reply-To: <8F120FA493CAD743B30EEB8F356985B50207C8A1@AUSXMBT102VS1.amer.dell.com>
Message-ID: <Pine.LNX.4.33.0109171923290.24626-100000@ping.us.dell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Appologies for the HTML mail. 

I applied that patch to a 2.4.9ac10 kernel, and it still loops the
/proc/partitions.


>       -----Original Message-----
>       From: Robert Macaulay
>       Sent: Mon 9/17/2001 5:54 PM
>       To: Erik Andersen
>       Cc: Colonel; linux-kernel@vger.kernel.org
>       Subject: Re: /proc/partitions hosed in 2.4.9-ac10
> 
> I have the problem as well, and my physical sector size is 512.
> I'll try
> the patch
> 
> On Mon, 17 Sep 2001, Erik Andersen wrote:
> 
> >
> > On Mon Sep 17, 2001 at 03:32:03PM -0700, Colonel wrote:
> > >
> > > Works fine here:
> >
> > But none of your devices have 2048 byte physical sectors,
> > which is the case with my MO drives, and that appears to
> > be the root of the problem,
> >
> >  -Erik
> >
> > --
> > Erik B. Andersen   email:  andersee@debian.org, formerly of
> Lineo
> > --This message was written using 73% post-consumer electrons--
> > -
> > To unsubscribe from this list: send the line "unsubscribe
> linux-kernel"
> > in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
> >
> >
> 
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
> 

