Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264878AbSKEPv5>; Tue, 5 Nov 2002 10:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264879AbSKEPv5>; Tue, 5 Nov 2002 10:51:57 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:62856 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S264878AbSKEPv5>; Tue, 5 Nov 2002 10:51:57 -0500
Date: Tue, 5 Nov 2002 09:58:26 -0600 (CST)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Skip Ford <skip.ford@verizon.net>
cc: george anzinger <george@mvista.com>,
       Davide Libenzi <davidel@xmailserver.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.46
In-Reply-To: <200211050401.gA541YPi006905@pool-141-150-241-241.delv.east.verizon.net>
Message-ID: <Pine.LNX.4.44.0211050957150.20254-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Nov 2002, Skip Ford wrote:

> > On Mon, 4 Nov 2002, george anzinger wrote:
> > 
> > > I think we need a newer objcopy :(
> > 
> > Alternatively, use this patch. (It's not really needed to force people to 
> > upgrade binutils when ld can do the job, as it e.g. does in 
> > arch/i386/boot/compressed/Makefile already).
> >
> > -	( cd $(obj) ; ./gen_init_cpio | gzip -9c > initramfs_data.cpio.gz )
> > +	( cd $(obj) ; ./$< | gzip -9c > $@ )
> 
> I get errors with your patch.  I had to remove the 'cd $(obj)' above
> from usr/Makefile.

Right, I shouldn't do these last minute changes without re-testing...

Will send a follow-up patch.

--Kai


