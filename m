Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129359AbRB1X6j>; Wed, 28 Feb 2001 18:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129389AbRB1X6U>; Wed, 28 Feb 2001 18:58:20 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:31503 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S129359AbRB1X6P>;
	Wed, 28 Feb 2001 18:58:15 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200102282358.f1SNw7b177652@saturn.cs.uml.edu>
Subject: Re: Will Mosix go into the standard kernel?
To: newt@scyld.com (Daniel Ridge)
Date: Wed, 28 Feb 2001 18:58:07 -0500 (EST)
Cc: beowulf@beowulf.org,
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <Pine.LNX.4.21.0102281732210.22184-100000@eleanor.wdhq.scyld.com> from "Daniel Ridge" at Feb 28, 2001 06:06:37 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Ridge writes:

> Fellow Beowulfers,
> 
> I have yet to hear a compelling argument about why any of them should 
> go into the standard kernel -- let alone a particular one or a duck of a
> compromise.
> 
> The Scyld system is based on BProc -- which requires only a 1K patch to
> the kernel. This patch adds 339 net lines to the kernel, and changes 38
> existing lines.

Well, that explains your viewpoint and your motivation. :-)

> I think we should instead focus our collective will on removing things
> from the kernel. For years, projects like ALSA, pcmcia-cs, and VMware

ALSA: driver work gets done twice

pcmcia-cs: this was so bad that Linus himself was unable to install
Linux on his new laptop, so now PCMCIA support is in the kernel.

VMware: quite a pain I think

You are basically suggesting the often-rejected "split up the kernel"
idea. I think the linux-kernel FAQ covers this.

> have done an outstanding job sans 'inclusion' and we should more
> frequently have the courage to do the same. RedHat and other linux vendors
> have demonstrated ably that they know how to build and package systems
> that draw together these components in an essentially reasonable way. 

So people should only get kernels from linux vendors? This is great
for your business I'd imagine, but one of the nice things about Linux
is that you can replace the kernel without too much trouble.
