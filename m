Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263144AbTCSQsh>; Wed, 19 Mar 2003 11:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263145AbTCSQsh>; Wed, 19 Mar 2003 11:48:37 -0500
Received: from chaos.analogic.com ([204.178.40.224]:26247 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S263144AbTCSQsg> convert rfc822-to-8bit; Wed, 19 Mar 2003 11:48:36 -0500
Date: Wed, 19 Mar 2003 12:01:37 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Xavier Bestel <xavier.bestel@free.fr>
cc: Matthias Schniedermeyer <ms@citd.de>,
       "Richard B. Johnson" <johnson@quark.analogic.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Everything gone!
In-Reply-To: <1048091858.989.10.camel@bip.localdomain.fake>
Message-ID: <Pine.LNX.4.53.0303191158180.31905@chaos>
References: <Pine.LNX.4.53.0303191041370.27397@quark.analogic.com> 
 <20030319160437.GA22939@citd.de> <1048091858.989.10.camel@bip.localdomain.fake>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Mar 2003, Xavier Bestel wrote:

> Le mer 19/03/2003 à 17:04, Matthias Schniedermeyer a écrit :
>
> > rm -rf *
> > Should do the same(*) but with much better speed.
> >
> > Normaly the system should lockup at sometime while doing it.
> >
> >
> >
> >
> > *: OK. The version above will "break" in the middle after "/bin/rm" (or
> > "/lib/libc.so.6") got deleted.
>
> That would be surprising. Did you actually try it ? :)
>
> 	Xav

I think that, with a single instance of `rm`, not as written above,
this would complete because all the open runtime libraries would
remain mem-mapped until the last close. So, I think you could
remove everything with -rf except the programs that will return
'text file busy' errors because they are open for execution.

An, no. I am not going to try it! Well maybe sometime when I
mount an alternate root that I am going to replace.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

