Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290200AbSBKTKj>; Mon, 11 Feb 2002 14:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290206AbSBKTKa>; Mon, 11 Feb 2002 14:10:30 -0500
Received: from adsl-64-168-153-221.dsl.snfc21.pacbell.net ([64.168.153.221]:3728
	"EHLO unifiedcomputing.com") by vger.kernel.org with ESMTP
	id <S290200AbSBKTKV>; Mon, 11 Feb 2002 14:10:21 -0500
Message-Id: <4.2.2.20020211110312.00b0e0c0@10.10.10.29>
X-Mailer: QUALCOMM Windows Eudora Pro Version 4.2.2 
Date: Mon, 11 Feb 2002 11:06:44 -0800
To: Pavel Machek <pavel@suse.cz>
From: "S. Parker" <linux@sparker.net>
Subject: Re: Sysrq enhancement: process kill facility
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        marcelo@conectiva.com.br
In-Reply-To: <20020209201955.GC851@elf.ucw.cz>
In-Reply-To: <4.2.2.20020208092102.00aa5eb8@10.10.10.29>
 <4.2.2.20020208092102.00aa5eb8@10.10.10.29>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I certainly have no particular preference for what this is called.
Is there support for dropping the existing kIll and me re-submitting
these changes that way?  (I've never imagined how kIll actually helped.)

Cheers,

         ~sparker

At 12:19 PM 2/9/2002 , Pavel Machek wrote:
>Hi!
>
> >
> > You enter <alt>-<sysrq>-n ("nuke"), and then prompts for the pid.  It
> > supports
> > backspace and control-U.  On serial ports, it retains the same semantics:
> > a break activates this as a sysrq sequence, but if more than 5-seconds pass
> > without any input, it drops out of processing input as a sysrq.
> >
> > Feedback welcome, please cc: me directly.
>
>Looks good to me; (maybe you could reuse from 'kIll' as killing of all
>processes is hardly ever usefull).
>                                                                         Pavel
>--
>(about SSSCA) "I don't say this lightly.  However, I really think that the 
>U.S.
>no longer is classifiable as a democracy, but rather as a plutocracy." --hpa

Cheers,

	~sparker

