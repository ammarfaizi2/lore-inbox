Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129428AbQLLXyx>; Tue, 12 Dec 2000 18:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130407AbQLLXyn>; Tue, 12 Dec 2000 18:54:43 -0500
Received: from twinlark.arctic.org ([204.107.140.52]:7435 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S129428AbQLLXyc>; Tue, 12 Dec 2000 18:54:32 -0500
Date: Tue, 12 Dec 2000 15:24:01 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Miles Lane <miles@megapathdsl.net>
cc: "Mohammad A. Haque" <mhaque@haque.net>, Greg KH <greg@wirex.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: how to capture long oops w/o having second machine
In-Reply-To: <3A368FE2.1050205@megapathdsl.net>
Message-ID: <Pine.LNX.4.30.0012121522430.21906-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i've always been curious why none of the crash dump patches are default.
an oops dumper alone would seem to be most useful.  (i know anything more
would be unacceptable 'cause linus isn't into debuggers ;)

-dean

On Tue, 12 Dec 2000, Miles Lane wrote:

>
> Try reading:
>
> 	http://www.linuxhq.com/kernel/v2.3/doc/oops-tracing.txt.html
>
> It mentions:
>
>      Patch the kernel with one of the crash dump patches.  These save
>      data to a floppy disk or video rom or a swap partition.  None of
>      these are standard kernel patches so you have to find and apply
>      them yourself.  Search kernel archives for kmsgdump, lkcd and
>      oops+smram.
>
> I don't know if the "dump to floppy" patch is maintained for the
> 2.4.0 series.
>
> 	Miles
>
> Mohammad A. Haque wrote:
>
> > Nope, this didn't fly. Would have been neat if it did work. Maybe it can
> > be made to work for future use?
> >
> > On Tue, 12 Dec 2000, Greg KH wrote:
> >
> >
> >> I don't know if /dev/ttyUSBX would work, but I think it would.  People
> >> have successfully run consoles through the usb-serial drivers, but I'm
> >> not sure if the oops main console requires something different (like
> >> registering itself actually as a console?)
> >>
> >> And then there's the nice problem of the fact that if the oops comes
> >> from the USB code, you will not see it come out the usb-serial driver :)
> >>
> >> Let me know if you try this, and have any success (or find that it
> >> doesn't work.)
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
