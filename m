Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130301AbRCBD7N>; Thu, 1 Mar 2001 22:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130304AbRCBD7D>; Thu, 1 Mar 2001 22:59:03 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:46855 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S130301AbRCBD6r>; Thu, 1 Mar 2001 22:58:47 -0500
Date: Thu, 1 Mar 2001 22:59:42 -0500 (EST)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
X-X-Sender: <mharris@asdf.capslock.lan>
To: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>
cc: "Matilainen Panu (NRC/Helsinki)" <panu.matilainen@nokia.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.x very unstable on 8-way IBM 8500R
In-Reply-To: <Pine.LNX.4.21.0103011701360.8542-100000@sol.compendium-tech.com>
Message-ID: <Pine.LNX.4.33.0103012259120.1207-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
Copyright: Copyright 2001 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Mar 2001, Dr. Kelsey Hudson wrote:

>> I've been playing around with 8-way IBM8500R (8x700MHz Xeon) with 4.5GB
>> memory & AIC7xxx SCSI-controller. It's perfectly stable with 2.2-kernel
>> (from Red Hat 7) but very erratic on all 2.4-kernels I've tried it with
>> (2.4.[012], compiled both with egcs and RH7's gcc-2.96, both share the
>
>Under redhat 7 you should use kgcc to compile the kernel, since gcc2.96 is
>inherently broken(*).

http://www.bero.org/gcc296.html

>> same symptoms). It did have a ServeRAID controller too but IBM suggested
>> we take it out since 4500R also had problems with it on 2.4 but it didn't
>> make any difference at all. Also tried to turn off highmem support but
>> didn't make difference either.
>
>(*)  redhat chose to ship an experimental compiler with this release of
>     the distribution that has a great many bugs. to ensure proper kernel
>     compillation another proven version of gcc was included, but called
>     kgcc instead. You should always use this to compile your kernels
>     under redhat 7 until the newer version of gcc is released.

http://www.bero.org/gcc296.html



----------------------------------------------------------------------
    Mike A. Harris  -  Linux advocate  -  Free Software advocate
          This message is copyright 2001, all rights reserved.
  Views expressed are my own, not necessarily shared by my employer.
----------------------------------------------------------------------
Red Hat Linux:  http://www.redhat.com
Download for free:  ftp://ftp.redhat.com/pub/redhat/redhat-6.2/

