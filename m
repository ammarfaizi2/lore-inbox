Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263282AbSJHTXT>; Tue, 8 Oct 2002 15:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263289AbSJHTWU>; Tue, 8 Oct 2002 15:22:20 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:16776 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S263282AbSJHTWB>; Tue, 8 Oct 2002 15:22:01 -0400
Date: Tue, 8 Oct 2002 14:27:15 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: James Bottomley <James.Bottomley@HansenPartnership.com>
cc: Adrian Bunk <bunk@fs.tum.de>, Alan Cox <alan@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.41-ac1 
In-Reply-To: <200210081900.g98J0CL09162@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0210081426380.32256-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Oct 2002, James Bottomley wrote:

> kai@tp1.ruhr-uni-bochum.de said:
> > And you do not really want to do this, you rather want CONFIG_VOYAGER
> > to  define_bool CONFIG_X86_SMP y and be done without ugly hacks in the
> >  Makefiles. 
> 
> I'm afraid voyager can't do that.  CONFIG_SMP was split from CONFIG_X86_SMP 
> for precisely this reason.  CONFIG_X86_SMP is for generic intel SMP 
> architectures (i.e. APIC based).  The voyager has it's own rather wierd VIC 
> based SMP architecture.
> 
> However, how about the attached patch, which fixes the problem for me (I can 
> only compile, not test, because my voyager system is at home and I'm away on 
> business)

The patch does exactly what I would have suggested next, so I am very 
happy with it ;)

--Kai


