Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262234AbTIMWHQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 18:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262236AbTIMWHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 18:07:16 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:24061 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262234AbTIMWHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 18:07:14 -0400
Date: Sun, 14 Sep 2003 00:07:06 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] better i386 CPU selection
Message-ID: <20030913220706.GM27368@fs.tum.de>
References: <20030913125103.GE27368@fs.tum.de> <20030913161149.GA1750@redhat.com> <20030913182159.GA10047@gtf.org> <20030913183758.GQ1191@redhat.com> <20030913185319.GC10047@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030913185319.GC10047@gtf.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 13, 2003 at 02:53:19PM -0400, Jeff Garzik wrote:
> > 
> > Echo 2 lines above. People do use 386 kernels for install kernels
> > on distros. Removing errata workarounds means distros start randomly
> > exploding during installs.
> 
> You're not understanding the model.  I understand your comment about
> using 386 kernels for install kernels.  If Adrian's patch is done
> right, _absolutely nothing should change_ in your described scenario.
> 
> Distros would continue doing what they've always done, and would
> continue to get the behavior they have always gotten.
>...

I'm not sure whether you understand my intention.

Nothing will change, except that if you want to support all CPUs, you 
have to select all CPUs instead of 386.

My main intention is to get a clear user interface (user = person 
compiling the kernel) that suits everyone's needs and to put all the 
logic what to do when you plan to support several different CPUs into 
the kernel.

I don't like the current user interface that says "if you want to 
support both an Athlon and a Pentium 4 in your kernel use the Pentium III
option. And for better optimization, also check the "generic" option".

> 	Jeff

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

