Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136361AbRDWDVX>; Sun, 22 Apr 2001 23:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136363AbRDWDVN>; Sun, 22 Apr 2001 23:21:13 -0400
Received: from leng.mclure.org ([64.81.48.142]:6408 "EHLO
	leng.internal.mclure.org") by vger.kernel.org with ESMTP
	id <S136361AbRDWDVD>; Sun, 22 Apr 2001 23:21:03 -0400
Date: Sun, 22 Apr 2001 20:20:56 -0700
From: Manuel McLure <manuel@mclure.org>
To: Brett <brett@macfeegles.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with "su -" and kernels 2.4.3-ac11 and higher
Message-ID: <20010422202056.C970@ulthar.internal.mclure.org>
In-Reply-To: <20010422192520.A3618@ulthar.internal.mclure.org> <Pine.LNX.4.21.0104231237130.13278-100000@tae-bo.generica.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.21.0104231237130.13278-100000@tae-bo.generica.dyndns.org>; from brett@macfeegles.com.au on Sun, Apr 22, 2001 at 19:42:41 -0700
X-Mailer: Balsa 1.1.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2001.04.22 19:42 Brett wrote:
> On Sun, 22 Apr 2001, Manuel McLure wrote:
> >
> > 
> > On 2001.04.22 14:38 Andrzej Krzysztofowicz wrote:
> > > > 
> > > > I'm having a problem with "su -" on ac11/ac12. ac5 doesn't show the
> > > > problem.
> > > > The problem is easy to reproduce - go to a console, log in as root,
> do
> > > an
> > > > "su -" (this will succeed) and then another "su -". The second "su
> -"
> > > > should hang - ps shows it started bash and that the bash process is
> > > > sleeping. You need to "kill -9" the bash to get your prompt back.
> > > 
> 
> No problem here either...
> Tried nesting 7 levels deep, a few times.
> 
> p75
> 
> # uname -a
> Linux lapsis 2.4.3-ac12 #2 Sun Apr 22 17:41:08 EST 2001 i586 unknown
> 
> # ls /lib/libc-*
> -rwxr-xr-x    1 root     root      1417065 Feb 17 14:57
> /lib/libc-2.2.2.so*
> 
> # gcc --version
> 2.95.3
> 
> # su --version
> su (GNU sh-utils) 2.0j
> 
> 	/ Brett
> 

In my case:

# su --version
su (GNU sh-utils) 2.0

# bash --version
GNU bash, version 2.04.21(1)-release (i386-redhat-linux-gnu)

# uname -a
Linux ulthar 2.4.3-ac12 #3 Sat Apr 21 23:15:08 PDT 2001 i686 unknown

# ls -l /lib/libc-*        
-rwxr-xr-x    2 root     root      1236396 Apr  6 14:58 /lib/libc-2.2.2.so

# kgcc --version
egcs-2.91.66


-- 
Manuel A. McLure KE6TAW | ...for in Ulthar, according to an ancient
<manuel@mclure.org>     | and significant law, no man may kill a cat.
<http://www.mclure.org> |             -- H.P. Lovecraft

