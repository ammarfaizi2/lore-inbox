Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286322AbSBCG6E>; Sun, 3 Feb 2002 01:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286336AbSBCG5y>; Sun, 3 Feb 2002 01:57:54 -0500
Received: from dsl092-237-176.phl1.dsl.speakeasy.net ([66.92.237.176]:6669
	"EHLO whisper.qrpff.net") by vger.kernel.org with ESMTP
	id <S286322AbSBCG5i>; Sun, 3 Feb 2002 01:57:38 -0500
Message-Id: <5.1.0.14.2.20020203015116.022aceb0@whisper.qrpff.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 03 Feb 2002 01:53:13 -0500
To: Thomas Hood <jdthood@mail.com>, linux-kernel@vger.kernel.org
From: Stevie O <stevie@qrpff.net>
Subject: Re: apm.c and multiple battery slots
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <1012705104.774.4.camel@thanatos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:58 PM 2/2/2002 -0500, Thomas Hood wrote:
>Stevie O <stevie@qrpff.net> wrote:
> > I suggest we change the first line to reflect an
> > overall battery status (i.e. average of all slots
> > in system).
>
>Sounds like a good idea.
>
> > Then we could add one line for each battery slot,
> > indicating <battery status> <battery flag> <battery left % >
> > <remaining time in seconds>
>
>How about putting each of these lines in a separate proc
>file?  This would avoid changing the format of /proc/apm,
>which would break things.

Or we could do something similar to what the IDE subsystem does, and have

/proc/apmbat/0 <- battery [slot] 0
/proc/apmbat/1 <- battery [slot] 1
...
/proc/apmbat/  <- battery [slot] N

I'd actually prefer to call it /proc/apm/ but obviously that won't work :)





--
Stevie-O

Real programmers use COPY CON PROGRAM.EXE

