Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136467AbREDRcL>; Fri, 4 May 2001 13:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136468AbREDRcB>; Fri, 4 May 2001 13:32:01 -0400
Received: from twinlark.arctic.org ([204.107.140.52]:7185 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S136467AbREDRbu>; Fri, 4 May 2001 13:31:50 -0400
Date: Fri, 4 May 2001 10:31:49 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Pavel Machek <pavel@suse.cz>
cc: Gregory Maxwell <greg@linuxpower.cx>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Helge Hafting <helgehaf@idb.hist.no>, <linux-kernel@vger.kernel.org>
Subject: Re: X15 alpha release: as fast as TUX but in user space (fwd)
In-Reply-To: <20010504100632.B13243@bug.ucw.cz>
Message-ID: <Pine.LNX.4.33.0105041031020.20277-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

um, presumably this new magic page won't eliminate the old syscall entry
points.  so just use those for UML.

-dean

On Fri, 4 May 2001, Pavel Machek wrote:

> Hi!
>
> > > > That means that for fooling closed-source statically-linked binary,
> > >
> > > If they are using glibc then you have the right to the object to link
> > > with the library and the library source under the LGPL. I dont know of any
> > > app using its own C lib
> >
> > Some don't use any libc at all, some just don't use it for the time call
> > that were talking about substituting.
> >
> > Lying about the time is a hack, pure and simple. It will still be possible
> > with magic pages. The fact that it will require more kernel hacking to
> > accomplish it is irrelevant.
>
> No. You are breaking self-virtualization here. That is not irrelevant.
>
> It used to require no kernel support before. Now it will require
> kernel support. That's step back. (Think uml).
>
> 								Pavel
> --
> I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
> Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

