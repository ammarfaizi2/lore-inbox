Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264872AbSLLR1v>; Thu, 12 Dec 2002 12:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264875AbSLLR1v>; Thu, 12 Dec 2002 12:27:51 -0500
Received: from packet.digeo.com ([12.110.80.53]:26618 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264872AbSLLR1u>;
	Thu, 12 Dec 2002 12:27:50 -0500
Message-ID: <3DF8C8E2.654208CE@digeo.com>
Date: Thu, 12 Dec 2002 09:35:30 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Schaufler <andreas.schaufler@gmx.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: NFS mounted rootfs possible via PCMCIA NIC ?
References: <200212112253.57325.andreas.schaufler@gmx.de> <3DF7BD7F.85C6FEA0@digeo.com> <200212121829.42237.andreas.schaufler@gmx.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Dec 2002 17:35:32.0194 (UTC) FILETIME=[DED62420:01C2A204]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Schaufler wrote:
> 
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> > > Hello list,
> > >
> > > I am trying to configure a notebook with a PCMCIA NIC to boot over
> > > network. (kernel 2.4.20)
> >
> > Nope.  The kernel does the NFS thing before bringing up cardbus.
> >
> > This patch worked, back in the 2.4.17 days.  It also fixes some
> > cardbus bugs.  I don't immediately recall what they were.
> 
> I got the 2.4.17 sources and applied the patch. yenta.c and main.c could not
> be patched automatically, so I tried to apply it by hand line by line.
> Unfortunately when I boot a kernel compiled witch this modified sources I get
> an "Unable to handle kernel pagin request at virtual address 0000413d"
> 
> Maybe this patch is to be used on some Pre Version of 2.4.17 ?!?!
> 

Sorry, that patch was against 2.4.20.  It was last tested in 2.4.17.
