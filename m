Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130074AbQKPTxP>; Thu, 16 Nov 2000 14:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129853AbQKPTxE>; Thu, 16 Nov 2000 14:53:04 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:35594 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129076AbQKPTwx>; Thu, 16 Nov 2000 14:52:53 -0500
Date: Thu, 16 Nov 2000 14:22:19 -0500 (EST)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
To: Nishant Rao <nishant@cs.utexas.edu>
cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Setting IP Options in the IP-Header
In-Reply-To: <Pine.LNX.4.21.0011161136160.5903-100000@crom.cs.utexas.edu>
Message-ID: <Pine.LNX.4.21.0011161421380.735-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
Copyright: Copyright 2000 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2000, Nishant Rao wrote:

>Date: Thu, 16 Nov 2000 11:55:24 -0600 (CST)
>From: Nishant Rao <nishant@cs.utexas.edu>
>To: Andi Kleen <ak@suse.de>
>Cc: linux-kernel@vger.kernel.org
>Content-Type: TEXT/PLAIN; charset=US-ASCII
>Subject: Re: Setting IP Options in the IP-Header
>
>Well, while what you say makes sense, it isn't exactly a solution to our
>problem.
>
>we are trying to expose and set a NEW option altogether. So our question 
>pertains more to what code we write in the kernel to create and expose a 
>new custom option. so for this, we would need to know the offsets of the
>current options like source routing etc and then hopefully try and stuff
>data from setting our option after the maximum that can be set by these
>other existing options.
>
>once that code is in place within the ip_build_options routine in the
>ip_options.c file in the linux kernel, we can then use the setsockopt() 
>at the application level to make sure that a packet is filled with the
>corresponding option.
>
>i hope i was able to explain my question more clearly.

RFC791 should give you all you need to know I believe, plus
examining the existing kernel sources. It's pretty basic.

----------------------------------------------------------------------
      Mike A. Harris  -  Linux advocate  -  Open source advocate
          This message is copyright 2000, all rights reserved.
  Views expressed are my own, not necessarily shared by my employer.
----------------------------------------------------------------------

Red Hat Linux:  http://www.redhat.com
Download for free:  ftp://ftp.redhat.com/pub/redhat/redhat-6.2/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
