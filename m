Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267951AbRGVKYb>; Sun, 22 Jul 2001 06:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267952AbRGVKYL>; Sun, 22 Jul 2001 06:24:11 -0400
Received: from smtp-server2.tampabay.rr.com ([65.32.1.39]:55207 "EHLO
	smtp-server2.tampabay.rr.com") by vger.kernel.org with ESMTP
	id <S267951AbRGVKYC>; Sun, 22 Jul 2001 06:24:02 -0400
Message-ID: <009601c11298$70a3da80$b6562341@cfl.rr.com>
From: "Mike Black" <mblack@csihq.com>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <000f01c111ff$73602ce0$c20e9c3e@host1> <3B59AFF7.8061645B@mandrakesoft.com> <01072201370202.02679@starship> <20010721165346.U3889@opus.bloom.county>
Subject: Re: [OT] Re: 2.4.7: wtf is "ksoftirqd_CPU0"
Date: Sun, 22 Jul 2001 06:24:06 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2462.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Actually -- is it possible (or desirable) to make ALL kernel daemons begin
with say "_" or some other special character to distinguish them from
userland threads?  The "k......d" paradigm is OK but not very distinctive.
That way you have a simple line in the kernel docs that says "Any process
with a leading _ is a kernel process and should NEVER be killed or otherwise
messed with except as noted elsewhere in the docs".

Also would make it easy for things like ps, top and other process-aware
things to have a really simple "show kernel processes only" option.


----- Original Message -----
From: "Tom Rini" <trini@kernel.crashing.org>
To: "Daniel Phillips" <phillips@bonn-fries.net>
Cc: "peter k." <spam-goes-to-dev-null@gmx.net>;
<linux-kernel@vger.kernel.org>
Sent: Saturday, July 21, 2001 7:53 PM
Subject: [OT] Re: 2.4.7: wtf is "ksoftirqd_CPU0"


> On Sun, Jul 22, 2001 at 01:37:02AM +0200, Daniel Phillips wrote:
> > On Saturday 21 July 2001 18:38, Jeff Garzik wrote:
> > > "peter k." wrote:
> > > > i just installed 2.4.7, now a new process called "ksoftirqd_CPU0"
> > > > is started automatically when booting (by the kernel obviously)?
> > > > why? what does it do? i didnt find any useful information on it in
> > > > linuxdoc / linux-kernel archives
> > >
> > > it is used internally, ignore it.
> >
> > It's pretty hard to ignore a process with a name that ugly ;-)
> >
> > How about just ksoft0 ?  Or kirq0?
>
> Now this is just getting silly.  It follows the same convention the
> 6-8 other k* daemons follow.  Would you want kswpd? kupd? kreclmd?
Probably
> not.
>
> --
> Tom Rini (TR1265)
> http://gate.crashing.org/~trini/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

