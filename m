Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273736AbRIQWye>; Mon, 17 Sep 2001 18:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273747AbRIQWyZ>; Mon, 17 Sep 2001 18:54:25 -0400
Received: from smtp5.us.dell.com ([143.166.83.100]:36106 "EHLO
	smtp5.us.dell.com") by vger.kernel.org with ESMTP
	id <S273736AbRIQWyH>; Mon, 17 Sep 2001 18:54:07 -0400
Date: Mon, 17 Sep 2001 17:54:30 -0500 (CDT)
From: Robert Macaulay <robert_macaulay@dell.com>
X-X-Sender: <robert@ping.us.dell.com>
Reply-To: Robert Macaulay <robert_macaulay@dell.com>
To: Erik Andersen <andersen@codepoet.org>
cc: Colonel <klink@clouddancer.com>, <linux-kernel@vger.kernel.org>
Subject: Re: /proc/partitions hosed in 2.4.9-ac10
In-Reply-To: <20010917164824.A27116@codepoet.org>
Message-ID: <Pine.LNX.4.33.0109171753400.24019-100000@ping.us.dell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have the problem as well, and my physical sector size is 512. I'll try 
the patch

On Mon, 17 Sep 2001, Erik Andersen wrote:

> 
> On Mon Sep 17, 2001 at 03:32:03PM -0700, Colonel wrote:
> >
> > Works fine here:
> 
> But none of your devices have 2048 byte physical sectors,
> which is the case with my MO drives, and that appears to
> be the root of the problem,
> 
>  -Erik
> 
> --
> Erik B. Andersen   email:  andersee@debian.org, formerly of Lineo
> --This message was written using 73% post-consumer electrons--
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
> 

