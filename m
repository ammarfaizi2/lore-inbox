Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291214AbSBGSe7>; Thu, 7 Feb 2002 13:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291194AbSBGSdY>; Thu, 7 Feb 2002 13:33:24 -0500
Received: from pop.gmx.net ([213.165.64.20]:16017 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S291215AbSBGSch>;
	Thu, 7 Feb 2002 13:32:37 -0500
Message-ID: <3C62C82D.74C9D712@gmx.net>
Date: Thu, 07 Feb 2002 19:32:13 +0100
From: Gunther Mayer <gunther.mayer@gmx.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Patrick Mochel <mochel@osdl.org>
CC: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: driverfs support for motherboard devices
In-Reply-To: <Pine.LNX.4.33.0202070922460.25114-100000@segfault.osdlab.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel wrote:

> On Thu, 7 Feb 2002, Dave Jones wrote:
>
> > On Thu, Feb 07, 2002 at 01:31:25PM +0100, Pavel Machek wrote:
> >  > > I suspect PnPBIOS knows for the 486. There is PnPbios code in 2.4-ac
> >  > > perfectly ready for a 2.5 merger
> >  > PnPBIOS is nasty, and I suspect it is not present/working on all
> >  > models, right?
> >
> >  For the most part it's fine, it just needs the floppy driver / ps2
> >  driver (and maybe some others) fixed up to not allocate regions
> >  that pnpbios already reserved. Other than these issues, it seems
> >  to be working well. It's certainly handled itself ok on all my
> >  test boxes (Even the weird compaq with the fscked up pnpbios --
> >  it claims to have pnpbios, yet when you call it, you get feature
> >  not supported return codes. cute.)
>
> Hey, speaking of PnPBios, is there a spec somewhere?

http://www.microsoft.com/hwdev/tech/PnP/default.asp


