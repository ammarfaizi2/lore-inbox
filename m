Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263329AbRFAQFH>; Fri, 1 Jun 2001 12:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263313AbRFAQE5>; Fri, 1 Jun 2001 12:04:57 -0400
Received: from mailhost.idcomm.com ([207.40.196.14]:46734 "EHLO
	mailhost.idcomm.com") by vger.kernel.org with ESMTP
	id <S263574AbRFAQEr>; Fri, 1 Jun 2001 12:04:47 -0400
Message-ID: <3B17BD33.F2DC6372@idcomm.com>
Date: Fri, 01 Jun 2001 10:05:07 -0600
From: "D. Stimits" <stimits@idcomm.com>
Reply-To: stimits@idcomm.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-ac5-1 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: missing sysrq
In-Reply-To: <200106010338.VAA13405@totalrecall.idcomm.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dieter Nützel wrote:
> 
> > D. Stimits wrote:
> >
> > > Bernd Eckenfels wrote:
> > > >
> > > In article <3B15EF16.89B18D@idcomm.com> you wrote:
> > > > However, if I go to /proc/sys/kernel/sysrq does not exist.
> > >
> > > It is a compile time option, so the person who compiled your kernel
> > > left it out.
> >
> > I compiled it, and the sysrq is definitely in the config. No doubt at
> > all. I also use make mrproper and config again before dep and actual
> > compile. Maybe it is just a quirk/oddball.
> >
> > D. Stimits, stimits@idcomm.com
> 
> Have you tried "echo 1 > /proc/sys/kernel/sysrq"?
> You need both, compiled in and activation.

It is compiled in, but the echo is summarily rejected. Root is not
allowed to write to that file, which doesn't exist. I'm going to just
wipe out everything from that kernel and redo the whole thing.

D. Stimits, stimits@idcomm.com

> 
> Regards,
>         Dieter
> --
> Dieter Nützel
> Graduate Student, Computer Science
> 
> email: nuetzel@kogs.informatik.uni-hamburg.de
> @home: Dieter.Nuetzel@hamburg.de
