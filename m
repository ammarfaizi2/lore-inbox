Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266053AbUFDWzD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266053AbUFDWzD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 18:55:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266050AbUFDWyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 18:54:49 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:28873 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266041AbUFDWw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 18:52:56 -0400
Date: Sat, 5 Jun 2004 00:52:47 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Eric BEGOT <eric_begot@yahoo.fr>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.27-pre5
Message-ID: <20040604225247.GH7744@fs.tum.de>
References: <20040603022432.GA6039@logos.cnet> <40C08A0D.9010003@yahoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40C08A0D.9010003@yahoo.fr>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2004 at 04:41:17PM +0200, Eric BEGOT wrote:
> Marcelo Tosatti wrote:
> 
> >Hi, 
> >
> >Here goes -pre5.
> >
> >This time we have merges from Jeff's -netdrivers tree, David's -net tree, 
> >including a fix for compilation error without CONFIG_SCTP set, SPARC64 
> >update,
> >i810_audio fixes, amongst others.
> >
> > 
> >
> when compiling linux-2.4.27-pre5 under a x86 architecture, I've a lot of 
> warnings :
> 
> In file included from 
> /usr/src/devel//usr/src/devel/include/linux/modules/i386_ksyms.ver:127:1: 
> warning: "__ver_atomic_dec_and_lock" redefined
> In file included from /usr/src/devel/include/linux/modversions.h:70,
>                from <command line>:8:
> /usr/src/devel/include/linux/modules/dec_and_lock.ver:1:1: warning: this 
> is the location of the previous definition
> 
> __ver_atomic_dec_and_lock is declared two times. Maybe it lacks a #ifdef 
> somewhere in the modversions.h no ?
> The compilation doesn't fail bu it's not very nice :)

Please send your .config .

TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

