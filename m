Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313113AbSEVMgV>; Wed, 22 May 2002 08:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313114AbSEVMgU>; Wed, 22 May 2002 08:36:20 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:3602 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S313113AbSEVMgT>; Wed, 22 May 2002 08:36:19 -0400
Date: Wed, 22 May 2002 13:36:13 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: "David S. Miller" <davem@redhat.com>, paulus@samba.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.17 /dev/ports
Message-ID: <20020522133613.D16934@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.44.0205202211040.949-100000@home.transmeta.com> <3CEB5F75.4000009@evision-ventures.com> <15595.30247.263661.42035@argo.ozlabs.ibm.com> <20020522.035435.68675894.davem@redhat.com> <3CEB6F31.2000301@evision-ventures.com> <20020522122617.B16934@flint.arm.linux.org.uk> <3CEB758B.2080304@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2002 at 12:40:11PM +0200, Martin Dalecki wrote:
> ARM io space is memmory mapped, so if any file you would
> rather use /dev/kmem...

kmem = kernel memory.  That may not be the same as the physical
memory (the fact that it is at present I find mostly irrelevant here).
/dev/mem is the more correct device to use for this purpose.

> Still no flames? This silence makes me suspicious....

They're in deep sleep at the moment; try getting a metal dustbin lid and
banging it hard - maybe you'll wake the dragons from hell... 8)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html
