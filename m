Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261994AbSIZBvk>; Wed, 25 Sep 2002 21:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262138AbSIZBvk>; Wed, 25 Sep 2002 21:51:40 -0400
Received: from blowme.phunnypharm.org ([65.207.35.140]:20490 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S261994AbSIZBvj>; Wed, 25 Sep 2002 21:51:39 -0400
Date: Wed, 25 Sep 2002 21:56:45 -0400
From: Ben Collins <bcollins@debian.org>
To: Shanti Katta <katta@csee.wvu.edu>
Cc: sparc-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Reg Sparc memory addresses
Message-ID: <20020926015645.GE28289@phunnypharm.org>
References: <1033005676.2723.5.camel@indus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1033005676.2723.5.camel@indus>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2002 at 10:01:15PM -0400, Shanti Katta wrote:
> Hi,
> I compiled user-mode-linux kernel on Ultrasparc with load address set to
> 00000000e0000000. But, when I try to debug the kernel, it just says
> cannot access memory at address 0xa00020b0.
> This error message remains the same no matter what I change the load
> address to. Can anyone guide me on valid memory addresses for userspace
> on Sparc? and how much different is that from x86 architecture?

You compiled it on ultrasparc, but I hope you compiled it as a "sparc"
target and not "sparc64".

I'm not familiar with how UML runs in user space, but I suspect it needs
to think it is sparc and not sparc64 for it to run in 32bit sparc
userspace (which is what ultrasparc runs at for most cases).

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
