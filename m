Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261485AbVAXKnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261485AbVAXKnh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 05:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbVAXKnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 05:43:37 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:64519 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261485AbVAXKnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 05:43:12 -0500
Date: Mon, 24 Jan 2005 11:43:07 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Magnus =?iso-8859-1?B?TeTkdHTk?= <novell@kiruna.se>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.11-rc2
Message-ID: <20050124104307.GB3515@stusta.de>
References: <Pine.LNX.4.58.0501211806130.3053@ppc970.osdl.org> <200501232211.45924.novell@kiruna.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200501232211.45924.novell@kiruna.se>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 23, 2005 at 10:11:45PM +0100, Magnus Määttä wrote:

> Hello

Hi Magnus,

> 
> It doesn't compile here, here's the error:
> 
>   CC      net/sched/sch_generic.o
> net/sched/sch_generic.c: In function `qdisc_restart':
> net/sched/sch_generic.c:128: error: label `requeue' used but not 
> defined
> make[2]: *** [net/sched/sch_generic.o] Error 1
> make[1]: *** [net/sched] Error 2
> make: *** [net] Error 2
> 
> 
> >From .config:
>...

I wasn't able to reproduce your problem.

Do you have any patches applied on top of 2.6.11-rc2 ?

If not, please send:
- your complete .config
- the output of
    bash scripts/ver_linux

TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

