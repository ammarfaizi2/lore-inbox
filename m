Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317790AbSGPMok>; Tue, 16 Jul 2002 08:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317808AbSGPMoj>; Tue, 16 Jul 2002 08:44:39 -0400
Received: from duteinh.et.tudelft.nl ([130.161.42.1]:28433 "EHLO
	duteinh.et.tudelft.nl") by vger.kernel.org with ESMTP
	id <S317790AbSGPMoi>; Tue, 16 Jul 2002 08:44:38 -0400
Date: Tue, 16 Jul 2002 14:47:03 +0200
From: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
To: nejhdeh <nejhdeh@aimedics.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Basic question
Message-ID: <20020716124703.GG1003@arthur.ubicom.tudelft.nl>
References: <200207161108.39689.nejhdeh@aimedics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207161108.39689.nejhdeh@aimedics.com>
User-Agent: Mutt/1.3.28i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2002 at 11:08:39AM +1000, nejhdeh wrote:
> I end up getting all the required source codes from kernel-source-2.4.18-5.RPM
> > 
> 
> > Now, it appears for me to use the kernel routines such as enable_irq 
> (defined 
> > in (/usr/src/linux-2.4.18-5/arch/i386/kernel/irq.c) I have to make the 
> entire 
> > kernel.o, since there are a lot of dependencies.
> > 
> 
> > Do I need to go this far?? 
> > 
> 
> > What is a simpler way to use these routines (in irq.c) with my application??
> > 
> 
> > How do I link this module (i.e irq.o) with my application?? I get heaps of 
> > unresoleved errors.

You can't link kernel sources against applications and expect that it
just works. The kernel is a separate piece of software, all kernel
communication with the kernel goes through the file IO and system call
APIs.


Erik

-- 
J.A.K. (Erik) Mouw
Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
