Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132589AbRDWJ4g>; Mon, 23 Apr 2001 05:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132615AbRDWJ4Q>; Mon, 23 Apr 2001 05:56:16 -0400
Received: from sunrise.pg.gda.pl ([153.19.40.230]:54484 "EHLO
	sunrise.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S132589AbRDWJ4P>; Mon, 23 Apr 2001 05:56:15 -0400
From: Andrzej Krzysztofowicz <ankry@pg.gda.pl>
Message-Id: <200104230956.LAA15940@sunrise.pg.gda.pl>
Subject: Re: Problem with "su -" and kernels 2.4.3-ac11 and higher
To: manuel@mclure.org (Manuel McLure)
Date: Mon, 23 Apr 2001 11:56:00 +0200 (MET DST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010422192520.A3618@ulthar.internal.mclure.org> from "Manuel McLure" at Apr 22, 2001 07:25:20 PM
Reply-To: ankry@green.mif.pg.gda.pl
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Manuel McLure wrote:"
> On 2001.04.22 14:38 Andrzej Krzysztofowicz wrote:
> > > 
> > > I'm having a problem with "su -" on ac11/ac12. ac5 doesn't show the
> > > problem.
> > > The problem is easy to reproduce - go to a console, log in as root, do
> > an
> > > "su -" (this will succeed) and then another "su -". The second "su -"
> > > should hang - ps shows it started bash and that the bash process is
> > > sleeping. You need to "kill -9" the bash to get your prompt back.
> > 
> > No problem here.
> > 
> > P233MMX
> > 
> > # uname -a
> > Linux kufel 2.4.3-ac12 #2 nie kwi 22 15:32:51 CEST 2001 i586 unknown
> > 
> > # ls -l /lib/libc-*
> > -rwxr-xr-x   1 root     root      1060168 Nov 19 11:17 /lib/libc-2.1.3.so
> > 
> > # gcc --version
> > egcs-2.91.66
> > (kernel with the fix by Niels Kristian Bech Jensen <nkbj@image.dk>)
> > 
> > # su --version
> > su (GNU sh-utils) 2.0
> > 
> > Maybe it is RH7 specyfic ? Or you have some compiler / hardware problem ?
> > 
> > Andrzej
> 
> Did you try nesting more than one "su -"? The first one after a boot works
> for me - every other one fails.

I've tried three levels.
But my systsem is based on RH6.x

> I'm on RH71 - this may be specific to this release. It's also
> kernel-dependent, I can reboot with ac5 and the problem does not happen.
> The kernel is compiled with the same compiler as yours.
> 
> My libc is 2.2.2 while yours is 2.1.3 - this may be the difference.

Andrzej
