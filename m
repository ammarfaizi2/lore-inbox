Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281022AbRKGWeh>; Wed, 7 Nov 2001 17:34:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281024AbRKGWeS>; Wed, 7 Nov 2001 17:34:18 -0500
Received: from ns2.arlut.utexas.edu ([129.116.174.1]:47115 "EHLO
	ns2.arlut.utexas.edu") by vger.kernel.org with ESMTP
	id <S281022AbRKGWeF>; Wed, 7 Nov 2001 17:34:05 -0500
From: "Eric Bresie" <ebresie@usa.net>
To: "EvilTypeGuy" <eviltypeguy@qeradiant.com>,
        "Linux-Kernel@Vger. Org" <linux-kernel@vger.kernel.org>
Subject: RE: Probing for Kernel Configuration
Date: Wed, 7 Nov 2001 16:36:28 -0600
Message-ID: <NDBBIOAPLEFIAKLGABEEIELMENAA.ebresie@usa.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Importance: Normal
In-Reply-To: <20011107140014.K31098@virtucon.warpcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes...doesn't that kind of assume you have all the necessary modules
compiled and available for the kernel you are using??  What I am proposing
is a probe that creates a config for use with compiling the kernel.

That doesn't work when you are trying out a new kernel...If I download linux
2.4.x which has all sorts of new modules...I don't think kudzu will setup
your kernel source configuration options, recompile the modules and then
activate the modules.

Also that is distribution specific also, which is seperate from the kernel
itself..

Eric

> From: Shawn [mailto:drevil@virtucon.warpcore.org]On Behalf Of EvilTypeGuy
> Sent: Wednesday, November 07, 2001 2:00 PM
>
> It exists already, it's called kudzu for RedHat, and other things for
other
> systems...At bootup time a redhat system will probe for new hardware using
kudzu
> and then make sure the appropriate modules are loaded if it recognizes the
> hardware...
>
> On Wed, Nov 07, 2001 at 01:32:35PM -0600, Eric Bresie wrote:
> > I just recently installed a new version of Redhat 7.2 and had problems
with
> > some of my devices not being supported as part of the stock
> > installation...this got me thinking...I noticed that when I did a lspci
that a
> > majority of my hardware was identified, but there was no guarantee that
the
> > module to support that hardware is present in the kernel or configured..
> >
> > Is it possible prior to kernel configuration to perhaps have something
like a
> > make newconfig or make probe-config to probe the system and give a guess
as to
> > what modules are needed for a given system...I guess you could think of
it
> > kind of as a plug-n-play for kernel configuration.
> >
> > I could see how this might require some mapping of hardware probed
information
> > to kernel config options which would then enable them (and if
appropriate set
> > to current settings).  And also might require some default utilities
like the
> > pci utilities, the usb utilities, scsi, etc...
> >
> > Any comments?
> >
> > Eric Bresie
> > ebresie@usa.net

