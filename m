Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290822AbSAYWMr>; Fri, 25 Jan 2002 17:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290825AbSAYWMm>; Fri, 25 Jan 2002 17:12:42 -0500
Received: from smtp-server6.tampabay.rr.com ([65.32.1.43]:3493 "EHLO
	smtp-server6.tampabay.rr.com") by vger.kernel.org with ESMTP
	id <S290822AbSAYWMd> convert rfc822-to-8bit; Fri, 25 Jan 2002 17:12:33 -0500
Message-Id: <200201252212.g0PMCWt16931@smtp-server6.tampabay.rr.com>
Content-Type: text/plain; charset=US-ASCII
From: GNUOrder <gnuorder@tampabay.rr.com>
Reply-To: gnuorder@tampabay.rr.com
To: linux-kernel@vger.kernel.org
Subject: Re: kernel newbie -- Compact Flash booting
Date: Fri, 25 Jan 2002 17:11:34 -0500
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <20020125065237.27862.qmail@web8104.in.yahoo.com> <20020125093733.D5808@mea-ext.zmailer.org>
In-Reply-To: <20020125093733.D5808@mea-ext.zmailer.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What if the CF connects to the IDE bus with an adapter?  Whould the IDE-CS 
still work or do you mean the IDE chipset itself doesn't support hot swapping 
or removable drives?  Also what kind of support is there for USB CF 
read/writers?

GO

On Friday 25 January 2002 02:37, Matti Aarnio wrote:
> On Thu, Jan 24, 2002 at 10:52:37PM -0800, Ramya Ravichandran wrote:
> > Hi,
> >
> >    I am a newbie to Linux.I have to develop an
> > embedded linux controller that boots from the Compact
> > flash card instead of the HD and work from RAM. I have
> > to have a bare minimum implementation of Linux kernel
> > to do this.
> >   I don't know where to start. Shud I start by writing
> > the driver for the CF card? What background knowledge
> > shud I have for implementing the kernel?
>
>   The compact flashes appear to PCMCIA as removable IDE drives.
>   Unless the PCMCIA-CF adapter is more than just two connectors
>   plus a set of wires in between, you should have no problems
>   at all.   Either IDE, or IDE_CS driver should do it.
>   (The IDE_CS will, of course, need the PCMCIA suite too to
>    support removable media.  IDE doesn't support removability.)
>
>   To boot from CF you need support in your boot-rom/flash
>   code.  Something which might not be true, unless you write
>   it yourself..
>
> > Please Help.Thanks
>
> /Matti Aarnio
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
