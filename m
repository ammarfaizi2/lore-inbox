Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133004AbRAPXwP>; Tue, 16 Jan 2001 18:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132120AbRAPXv4>; Tue, 16 Jan 2001 18:51:56 -0500
Received: from blackhole.compendium-tech.com ([206.55.153.26]:10234 "EHLO
	sol.compendium-tech.com") by vger.kernel.org with ESMTP
	id <S129790AbRAPXvq>; Tue, 16 Jan 2001 18:51:46 -0500
Date: Tue, 16 Jan 2001 15:51:06 -0800 (PST)
From: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>
To: Michael Meissner <meissner@spectacle-pond.org>
cc: Venkatesh Ramamurthy <Venkateshr@ami.com>,
        "'Dominik Kubla'" <dominik.kubla@uni-mainz.de>,
        "'David Woodhouse'" <dwmw2@infradead.org>,
        "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux not adhering to BIOS Drive boot order?
In-Reply-To: <20010116153757.A1609@munchkin.spectacle-pond.org>
Message-ID: <Pine.LNX.4.21.0101161534430.17397-100000@sol.compendium-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jan 2001, Michael Meissner wrote:

> > you're forgetting that in /etc/lilo.conf there is a directive called
> > 'append='... all the user has to do is merely add
> > 'append="scsihosts=whatever,whatever"' into their config file and rerun
> > lilo. problem solved
> 
> That's assuming you are using lilo.  Not everybody does or can use lilo, please
> don't assume that the way your system gets booted is the way everybody's does,
> particularly those on platforms other than the x86.

And I wasn't assuming that. There are several bootloaders for intel alone,
eg syslinux and grub, to name a couple. sparc has silo, alpha has
something else....whatever. 

> I must say, as a 5 year Linux user (and 23 year UNIX user/administrator), I do
> get tired of having to hunt down and deal with each of these changes that come
> up from time to time with Linux (ie, switching from ipfwadm to ipchains to
> netfilter, or in this case reordering how scsi adapters/network adapters are
> looked up).

I've been a Linux user/administrator for 3 years now. Before that I worked
on and administered UNIX machines for about 10 years, including SunOS,
HP/UX, and AIX. If you think that Linux is the only operating system to
undergo vast changes like that you're wrong: look at the SunOS to Solaris
switch....Basically the same operating system, no? However, many things
were different....OK its off topic but im sure you get the idea.

> > besides, how many 'end-users' do you know of that will have multiple scsi
> > adapters in one system? how many end-users -period- will have even a
> > *single* scsi adapter in their systems? do we need to bloat the kernel
> > with automatic things like this? no... i think it is handled fine the way
> > it is. if the user wants to add more than one scsi adapter into his
> > system, let him read some documentation on how to do so. (is this even a
> > documented feature? if not, i think it should be added to the docs...)
> 
> I'm an end-user, and I have 3 scsi-adapters of two different brands in my
> system.  Many of the people using Linux in high end things like servers,
> etc. will have multiple scsi controlers.  People are using Linux in lots of
> things from small embedded devices to large systems, and Linux needs to address
> needs in every area.

see, thats where you and i disagree...I wouldn't call you an end user
based upon that fact. End users (IMO) are those people who sit back and
buy a PC and expect it to Just Work(tm). Servers, embedded devices, et al 
(read: high-end applications) do not equate to end-user applications,
IMNSHO. Besides, *most* (and I say most because I've seen a sharp decline
in the mentality of Linux users as of late) people who are going to manage
a high-scale server are going to know what the hell they are doing in the
first place, so I highly doubt that the end-user argument holds merit
against this.

Linux, whether you like it or not, is a full-scale UNIX. It takes a good
(read: talented) system administrator to manage any UNIX properly...A good
sysadmin reads documentation....Seems clear enough to me. But, then again,
this is coming from an experienced sysadmin so my opinion *must* be
biased.

Talk to you later,

 Kelsey Hudson                                           khudson@ctica.com 
 Software Engineer
 Compendium Technologies, Inc                               (619) 725-0771
---------------------------------------------------------------------------     

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
