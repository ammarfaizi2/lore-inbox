Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293204AbSC3XM0>; Sat, 30 Mar 2002 18:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293242AbSC3XMQ>; Sat, 30 Mar 2002 18:12:16 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:60326 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S293204AbSC3XML>; Sat, 30 Mar 2002 18:12:11 -0500
Date: Sat, 30 Mar 2002 16:12:07 -0700
Message-Id: <200203302312.g2UNC7k10238@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Luuk van der Duim <l.a.van.der.duim@student.rug.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Devfs related] devfsd servise start does not complete
In-Reply-To: <1017335736.1816.30.camel@CC75757-A>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luuk van der Duim writes:
> During boot services are being started and 'devfsd', the first service,
> does not finish on recent 2.5 kernels. 
> 
> My devfsd version is: v1.3.25
> (Which works fine with 2.4.x kernels.)
> 
> I have tried earlier 2.5 kernels like 2.5.2 but they had 'other
> problems'. 
> 
> 2.5.6-dj2 seemed to work fine. 
> (I ran into other problems regarding my mouse but that is another
> story..)
> 
> 2.5.7-vanille: devfsd does not finish
> 2.5.7-dj1: devfsd does not finish
> 2.5.7-dj2: devfsd does not finish

Interesting. How about plain 2.5.6: does devfsd hang there as well?
Also check 2.4.19-pre5 both with and without devfs-patch-v199.11.
Since there appears to have been some change that has broken things,
you'll need to narrow down the particular pre-patch that caused the
breakage. Also, I'll need to see a list of processes currently running
when the hang occurs, plus an strace of devfsd.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
