Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313315AbSDFBtS>; Fri, 5 Apr 2002 20:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313641AbSDFBtI>; Fri, 5 Apr 2002 20:49:08 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:41656 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S313315AbSDFBsz>; Fri, 5 Apr 2002 20:48:55 -0500
Date: Fri, 05 Apr 2002 17:48:42 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Jeremy Jackson <jerj@coplanar.net>, linux-kernel@vger.kernel.org
Subject: Re: Faster reboots (and a better way of taking crashdumps?)
Message-ID: <1674141067.1018028922@[10.10.2.3]>
In-Reply-To: <00c501c1dce3$0ed806d0$7e0aa8c0@bridge>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> for 2, the BIOS sets the hardware to a known state,
> or if you can trigger *the* hardware reset line,
> which will also do that, then you're going through
> the BIOS again.  Now if you made your own bios...
> see www.linuxbios.org.

I need to avoid going through the BIOS ... this is a 
multiquad NUMA machine, and it doesn't take kindly
to the reboot through the BIOS for various reasons.
It also takes about 4 minutes, which is a pain ;-)

I have source code access to our BIOS if I really wanted, 
I just want to avoid modifying it if possible.

> there are patches where a kernel can load another
> kernel, also.

Hmmm ... sounds interesting ... any pointers?
 
> As for taking crashdumps on the way up, I believe
> (SGI's ?) linux kernel crash dumps does *exactly*
> this.

I was under the impression that most BIOSes reset
memory on reboot, so this was impossible during a
BIOS reboot?

M.

