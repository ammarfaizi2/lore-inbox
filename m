Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261419AbSIZRjB>; Thu, 26 Sep 2002 13:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261423AbSIZRjB>; Thu, 26 Sep 2002 13:39:01 -0400
Received: from [157.182.194.151] ([157.182.194.151]:45526 "EHLO
	mail.csee.wvu.edu") by vger.kernel.org with ESMTP
	id <S261419AbSIZRjA>; Thu, 26 Sep 2002 13:39:00 -0400
Subject: Re: Reg Sparc memory addresses
From: Shanti Katta <katta@csee.wvu.edu>
To: Ben Collins <bcollins@debian.org>
Cc: sparc-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
In-Reply-To: <20020926015645.GE28289@phunnypharm.org>
References: <1033005676.2723.5.camel@indus> 
	<20020926015645.GE28289@phunnypharm.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 26 Sep 2002 13:54:57 -0400
Message-Id: <1033062898.2037.43.camel@indus>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-09-25 at 21:56, Ben Collins wrote:
> On Wed, Sep 25, 2002 at 10:01:15PM -0400, Shanti Katta wrote:
> > Hi,
> > I compiled user-mode-linux kernel on Ultrasparc with load address set to
> > 00000000e0000000. But, when I try to debug the kernel, it just says
> > cannot access memory at address 0xa00020b0.
> > This error message remains the same no matter what I change the load
> > address to. Can anyone guide me on valid memory addresses for userspace
> > on Sparc? and how much different is that from x86 architecture?
> 
> You compiled it on ultrasparc, but I hope you compiled it as a "sparc"
> target and not "sparc64".

I compiled UML as "sparc64".

 
> I'm not familiar with how UML runs in user space, but I suspect it needs
> to think it is sparc and not sparc64 for it to run in 32bit sparc
> userspace (which is what ultrasparc runs at for most cases).
> 
So, I guess I need to compile UML as "sparc" target and debug it. I am
not sure how much of UML code runs in kernelspace and how much in
userspace. So, do I need to compile only the userspace code for UML as
"sparc" target or the whole of UML?

-Shanti 

