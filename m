Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286447AbSAXJ5H>; Thu, 24 Jan 2002 04:57:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286468AbSAXJ45>; Thu, 24 Jan 2002 04:56:57 -0500
Received: from port-213-20-228-147.reverse.qdsl-home.de ([213.20.228.147]:36612
	"EHLO drocklinux.dyndns.org") by vger.kernel.org with ESMTP
	id <S286447AbSAXJ4w> convert rfc822-to-8bit; Thu, 24 Jan 2002 04:56:52 -0500
Date: Thu, 24 Jan 2002 10:55:17 +0100 (CET)
Message-Id: <20020124.105517.730550260.rene.rebe@gmx.net>
To: mingo@elte.hu
Cc: zdenek@smetana.com, linux-kernel@vger.kernel.org
Subject: Re: Missing changelog to Ingo's J5 scheduler?
From: Rene Rebe <rene.rebe@gmx.net>
In-Reply-To: <Pine.LNX.4.33.0201232324550.14887-100000@localhost.localdomain>
In-Reply-To: <20020123135252.A58419@skuter.storm.com.pl>
	<Pine.LNX.4.33.0201232324550.14887-100000@localhost.localdomain>
X-Mailer: Mew version 2.1 on XEmacs 21.4.6 (Common Lisp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Missing changelog to Ingo's J5 scheduler?
Date: Wed, 23 Jan 2002 23:28:24 +0100 (CET)

> 
> On Wed, 23 Jan 2002, Zdenek Smetana wrote:
> 
> > I can't find it.
> 
> J5 is the next step towards better interactiveness. Lowered the default
> timeslice length from 250 msecs to 150 msecs - long timeslices were
> clearly causing problems for certain applications.

Yes. -J5 is even better here. With -J4 moving windows arround or doing
other GUI intensive stuff was interactive for a short time (1-2
seconds?) - and then the programm lost all interactivity (with some
unniced gcc in the background ...). With -J5 all applications keep
smoth even with two rebuilds (unniced) of a distribution running!

 10:54am  up  1:03,  4 users,  load average: 4.08, 3.08, 2.39
116 processes: 110 sleeping, 5 running, 1 zombie, 0 stopped
CPU states: 83.6% user, 16.3% system,  0.0% nice,  0.0% idle
Mem:   513912K av,  498908K used,   15004K free,       0K shrd,  144312K buff
Swap:  524624K av,      92K used,  524532K free                  256536K cached

> there are some changes in my tree that will be -J6, will write a fuller
> changelog, there are cleanups from other people included as well.
> 
> 	Ingo

k33p h4ck1n6
  René

-- 
René Rebe (Registered Linux user: #248718 <http://counter.li.org>)

eMail:    rene.rebe@gmx.net
          rene@rocklinux.org

Homepage: http://drocklinux.dyndns.org/rene/

Anyone sending unwanted advertising e-mail to this address will be
charged $25 for network traffic and computing time. By extracting my
address from this message or its header, you agree to these terms.
