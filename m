Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130237AbRCBBEm>; Thu, 1 Mar 2001 20:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130242AbRCBBEd>; Thu, 1 Mar 2001 20:04:33 -0500
Received: from blackhole.compendium-tech.com ([206.55.153.26]:22777 "EHLO
	sol.compendium-tech.com") by vger.kernel.org with ESMTP
	id <S130237AbRCBBEP>; Thu, 1 Mar 2001 20:04:15 -0500
Date: Thu, 1 Mar 2001 17:04:09 -0800 (PST)
From: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>
To: "Matilainen Panu (NRC/Helsinki)" <panu.matilainen@nokia.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.x very unstable on 8-way IBM 8500R
In-Reply-To: <Pine.LNX.4.30.0103011229500.23756-100000@godzilla.research.nokia.com>
Message-ID: <Pine.LNX.4.21.0103011701360.8542-100000@sol.compendium-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Mar 2001, Matilainen Panu (NRC/Helsinki) wrote:

> I've been playing around with 8-way IBM8500R (8x700MHz Xeon) with 4.5GB
> memory & AIC7xxx SCSI-controller. It's perfectly stable with 2.2-kernel
> (from Red Hat 7) but very erratic on all 2.4-kernels I've tried it with
> (2.4.[012], compiled both with egcs and RH7's gcc-2.96, both share the

Under redhat 7 you should use kgcc to compile the kernel, since gcc2.96 is
inherently broken(*). 

> same symptoms). It did have a ServeRAID controller too but IBM suggested
> we take it out since 4500R also had problems with it on 2.4 but it didn't
> make any difference at all. Also tried to turn off highmem support but
> didn't make difference either.

(*)  redhat chose to ship an experimental compiler with this release of
     the distribution that has a great many bugs. to ensure proper kernel
     compillation another proven version of gcc was included, but called
     kgcc instead. You should always use this to compile your kernels
     under redhat 7 until the newer version of gcc is released.

talk to you later,

 Kelsey Hudson                                           khudson@ctica.com 
 Software Engineer
 Compendium Technologies, Inc                               (619) 725-0771
---------------------------------------------------------------------------     

 

