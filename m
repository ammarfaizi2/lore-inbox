Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131330AbQKVKRJ>; Wed, 22 Nov 2000 05:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129873AbQKVKQt>; Wed, 22 Nov 2000 05:16:49 -0500
Received: from rumms.uni-mannheim.de ([134.155.50.52]:34993 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S131330AbQKVKQp>; Wed, 22 Nov 2000 05:16:45 -0500
To: Matti Aarnio <matti.aarnio@zmailer.org>
Subject: Re: Kernel bits
Message-ID: <974886395.3a1b95fb43c63@rumms.uni-mannheim.de>
Date: Wed, 22 Nov 2000 10:46:35 +0100 (MET)
From: 64738 <schwung@rumms.uni-mannheim.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <974881546.3a1b830ae5202@rumms.uni-mannheim.de> <20001122112952.Y28963@mea-ext.zmailer.org>
In-Reply-To: <20001122112952.Y28963@mea-ext.zmailer.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

uname -m tells me the hardware type of the machine. Is this determined while 
booting or is this the architecture I choose during 'make config'? 

Can't I run a i386 kernel on a ia64 machine? I know something like this from HP-
UX. You can choose between a 32 and a 64 bit kernel when installing, so knowing 
that you have a 64 bit capable machine does not say that you have a 64 bit 
kernel.
And I want to have the kernel bits, not the processor bits.


Matti Aarnio <matti.aarnio@zmailer.org> wrote:

> On Wed, Nov 22, 2000 at 09:25:46AM +0100, 64738 wrote:
> > Is there a syscall or something that can tell me whether I'm working
> on a 32- 
> > or a 64-bit kernel?
> 
> 	uname(2)
> 
> 	It gives out various strings from which you must then deduce,
> 	what kind of kernel is needed to run at what kind of machine.
> 
> 	And even though the machine is running with 64-bit kernel
> 	(e.g. alpha/sparc64/mips64/ia64), your userspace code might
> 	be running in 32-bit mode.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
