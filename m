Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136348AbRDWCmn>; Sun, 22 Apr 2001 22:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136347AbRDWCme>; Sun, 22 Apr 2001 22:42:34 -0400
Received: from juicer03.bigpond.com ([139.134.6.79]:64708 "EHLO
	mailin6.bigpond.com") by vger.kernel.org with ESMTP
	id <S136349AbRDWCmV>; Sun, 22 Apr 2001 22:42:21 -0400
Date: Mon, 23 Apr 2001 12:42:41 +1000
From: Brett <brett@macfeegles.com.au>
To: Manuel McLure <manuel@mclure.org>
cc: Andrzej Krzysztofowicz <kufel!ankry@green.mif.pg.gda.pl>,
        linux-kernel@vger.kernel.org
Subject: Re: Problem with "su -" and kernels 2.4.3-ac11 and higher
In-Reply-To: <20010422192520.A3618@ulthar.internal.mclure.org>
Message-ID: <Pine.LNX.4.21.0104231237130.13278-100000@tae-bo.generica.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Apr 2001, Manuel McLure wrote:
>
> 
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

No problem here either...
Tried nesting 7 levels deep, a few times.

p75

# uname -a
Linux lapsis 2.4.3-ac12 #2 Sun Apr 22 17:41:08 EST 2001 i586 unknown

# ls /lib/libc-*
-rwxr-xr-x    1 root     root      1417065 Feb 17 14:57 /lib/libc-2.2.2.so*

# gcc --version
2.95.3

# su --version
su (GNU sh-utils) 2.0j

	/ Brett

