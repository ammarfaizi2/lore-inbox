Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276822AbRJCBNC>; Tue, 2 Oct 2001 21:13:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276825AbRJCBMx>; Tue, 2 Oct 2001 21:12:53 -0400
Received: from air-1.osdlab.org ([65.201.151.5]:61201 "EHLO
	osdlab.pdx.osdl.net") by vger.kernel.org with ESMTP
	id <S276822AbRJCBMq>; Tue, 2 Oct 2001 21:12:46 -0400
Message-ID: <3BBA6556.E27FC534@osdlab.org>
Date: Tue, 02 Oct 2001 18:09:42 -0700
From: "Randy.Dunlap" <rddunlap@osdlab.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Dilger <adilger@turbolabs.com>
CC: mingo@elte.hu, linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
        netdev@oss.sgi.com, jgarzik@mandrakesoft.com
Subject: Re: [patch] netconsole-2.4.10-C2
In-Reply-To: <Pine.LNX.4.33.0109291146440.1715-100000@localhost.localdomain> <3BB77591.C1349C09@osdlab.org> <3BB77FD7.696CFC58@osdlab.org> <20010930220950.K930@turbolinux.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> 
> On Sep 30, 2001  13:25 -0700, Randy.Dunlap wrote:
> > I'm interested in using netconsole early (during boot).
> > Any problems doing that, other than getting module parameters
> > to it?  I can fix that part.
> 
> I was thinking about this as well.  It should be relatively easy to allow
> a line line "console=eth0,XX:XX:XX:XX:XX:XX,a.b.c.d" or similar.  The only
> slight problem might be in configuring the interface early enough in the
> boot process.  AFAIK (which isn't much in this area) the serial console
> has special "console" code which allows it to be used very early in the
> boot process.
> 
> You would obviously need to have the network driver compiled into the kernel
> and not a module.  Maybe Ingo can hack something where it is possible
> to initialize the network code very early in the boot process?

Well, I have netconsole-in-kernel (+ AD patches + RD patches)
built and parsing parameters, but not getting active nearly
soon enough.
I'll continue to work on that...hints appreciated/accepted.

~Randy
