Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132881AbRA3XCj>; Tue, 30 Jan 2001 18:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132945AbRA3XC3>; Tue, 30 Jan 2001 18:02:29 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:4618 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S132881AbRA3XCR>; Tue, 30 Jan 2001 18:02:17 -0500
Message-ID: <3A7747C6.5DBEA6EB@baldauf.org>
Date: Wed, 31 Jan 2001 00:01:26 +0100
From: Xuan Baldauf <xuan--lkml@baldauf.org>
Organization: Medium.net
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: de-DE,en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Keith Owens <kaos@ocs.com.au>, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Version 2.4.1 cannot be built.
In-Reply-To: <Pine.LNX.3.95.1010130175517.3672A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



"Richard B. Johnson" wrote:

> On Wed, 31 Jan 2001, Keith Owens wrote:
>
> > On Tue, 30 Jan 2001 16:45:16 -0500 (EST),
> > "Richard B. Johnson" <root@chaos.analogic.com> wrote:
> > >The subject says it all. `make dep` is now broken.
> > >make[4]: Entering directory `/usr/src/linux-2.4.1/drivers/acpi'
> > >Makefile:29: *** target pattern contains no `%'.  Stop.
> >
> > Which version of make are you running?
> >
>         3.74
>
> y'a mean even make isn't make anymore?
> Temporary 'fix' was `make -i` for the dependencies. All files I
> need built okay.

I experienced similar problems with make 3.76.1. After upgrading to 3.79.1,
the problems were gone.

>
>
> Cheers,
> Dick Johnson
>
> Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).
>
> "Memory is like gasoline. You use it up when you are running. Of
> course you get it all back when you reboot..."; Actual explanation
> obtained from the Micro$oft help desk.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
