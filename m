Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265384AbUAHPji (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 10:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265385AbUAHPjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 10:39:37 -0500
Received: from mail-08.iinet.net.au ([203.59.3.40]:17579 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S265384AbUAHPjc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 10:39:32 -0500
Date: Thu, 8 Jan 2004 23:40:16 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	<arvidjaar@mail.ru>
cc: =?koi8-r?Q?=22?=Greg KH=?koi8-r?Q?=22=20?= <greg@kroah.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: udev and devfs - The final word
In-Reply-To: <E1Aeab1-0009FQ-00.arvidjaar-mail-ru@f20.mail.ru>
Message-ID: <Pine.LNX.4.44.0401082333280.449-100000@donald.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jan 2004, [koi8-r] "Andrey Borzenkov[koi8-r] "  wrote:

>
> >     4) devfs does provide a deamon that userspace programs can hook > into
> >        to listen to see what devices are being created or removed.
> >   Constraints:
> >     1) devfs forces the devfs naming policy into the kernel.  If you
> >        don't like this naming scheme, tough.
>
> kernel imposes naming scheme for exporting devices in sysfs. It is
> possible to get rid of devfs_name in kernel and use those names
> that must exist anyway to support udev as well. devfs has
> devfsd that can call whatever naming agent you like.

Yes. I'm having trouble finding justification for that statement as
well.

devfs appears to have almost no device name info within it.

>
> >     2) devfs does not follow the LSB device naming standard.
>
> it is user-space (devfsd) issue, not kernel space (devfs)

And there is heaps of device naming going on in devfsd. As is what people
seem to be recommending.

> > Oh yeah, and there are the insolvable race conditions with the devfs
> > implementation in the kernel, but I'm not going to talk about them > right
>
> I do not argue that current devfs implementation is ugly and racy. I
> just beg you to point at what makes those races "unsolvable".
>
> > now, sorry.  See the linux-kernel archives if you care about them (and
> > if you use devfs, you should care...)
>
> I do care. Searching archives for devfs mostly brings "everyone knows
> this is crap". That is why I kindly ask you to show real evidence that
> the problems it has are unsolvable.

Again I'm also unable to find descriptions of the 'unsolvable' races.

I wouldn't mind knowing what they are either. Anyone?

Ian


