Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311930AbSCXUl0>; Sun, 24 Mar 2002 15:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311934AbSCXUlH>; Sun, 24 Mar 2002 15:41:07 -0500
Received: from gw.chygwyn.com ([62.172.158.50]:64772 "EHLO gw.chygwyn.com")
	by vger.kernel.org with ESMTP id <S311930AbSCXUkw>;
	Sun, 24 Mar 2002 15:40:52 -0500
From: Steven Whitehouse <steve@gw.chygwyn.com>
Message-Id: <200203242016.UAA05010@gw.chygwyn.com>
Subject: Re: NBD client/server broken?
To: aia21@cam.ac.uk (Anton Altaparmakov)
Date: Sun, 24 Mar 2002 20:16:38 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, pavel@suse.cz, linux-fsdevel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20020324183746.0452cec0@pop.cus.cam.ac.uk> from "Anton Altaparmakov" at Mar 24, 2002 06:46:11 PM
Organization: ChyGywn Limited
X-RegisteredOffice: 7, New Yatt Road, Witney, Oxfordshire. OX28 1NU England
X-RegisteredNumber: 03887683
Reply-To: Steve Whitehouse <Steve@ChyGwyn.com>
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> 
> Just to keep interested parties informed:
> 
> Thanks to Steven Whitehouse I found out that the latest nbd client/server 
> user space programs are in CVS on Sourceforge (the kernel nbd documentation 
> needs updating to point to http://sf.net/projects/nbd)...
> 
> And I have just submitted a patch to Steven to make the nbd-server 64-bit 
> clean on 32-bit machines and to allow proper auto detection of device size. 
> Hopefully we will see it entering the CVS soon. Otherwise patch is 
> available on request from me. (-:
> 
Its all there now and as you suggested I've added the configure script so
autoconf is no longer required to build it.

> Mounting a NTFS 15GiB partition over nbd (using ntfs tng driver) gave me a 
> data throughput of 7-10MiB/sec over 100MBit ethernet (going via switch and 
> a hub) which is quite impressive. (-:
> 
Also there is the zerocopy nbd patch I did for my UKUUG talk last year on my 
patches page: http://www.chygwyn.com/~steve/kpatch/ its out of date now
but my plan is to update and sumbit it for 2.5 in the next few weeks or so. 
It should make things even faster or at least more efficient if we are maxing 
out the network already :-)

Steve.

