Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310414AbSCPQDd>; Sat, 16 Mar 2002 11:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310416AbSCPQDY>; Sat, 16 Mar 2002 11:03:24 -0500
Received: from ns.suse.de ([213.95.15.193]:21258 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S310414AbSCPQDI>;
	Sat, 16 Mar 2002 11:03:08 -0500
To: John Levon <movement@marcelothewonderpenguin.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Nice values for kernel modules
In-Reply-To: <Pine.LNX.4.33.0203161126130.1090-100000@einstein.homenet.suse.lists.linux.kernel> <16358.1016282075@ocs3.intra.ocs.com.au.suse.lists.linux.kernel> <20020316154848.GA82190@compsoc.man.ac.uk.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 16 Mar 2002 17:03:07 +0100
In-Reply-To: John Levon's message of "16 Mar 2002 16:53:27 +0100"
Message-ID: <p73it7w1ow4.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Levon <movement@marcelothewonderpenguin.com> writes:

> On Sat, Mar 16, 2002 at 11:34:35PM +1100, Keith Owens wrote:
> 
> > I can see no good reason why the syscall table has been exported.
> 
> please don't change this. Just because it breaks on architectures X
> and Y doesn't mean it's useless.
> 
> System call snooping is an ugly thing but being able to do it without
> patching the kernel is incredibly useful. We're not unaware that
> it is arch-specific.

I can just second that. It would make it impossible to fix pice for 2.5 for 
example.

-Andi
