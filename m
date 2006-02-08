Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965201AbWBHEhq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965201AbWBHEhq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 23:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965200AbWBHEhq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 23:37:46 -0500
Received: from dialin-209-183-19-129.tor.primus.ca ([209.183.19.129]:60317
	"EHLO node1.opengeometry.net") by vger.kernel.org with ESMTP
	id S965201AbWBHEhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 23:37:45 -0500
Date: Tue, 7 Feb 2006 23:37:28 -0500
From: William Park <opengeometry@yahoo.ca>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org
Subject: Re: DMA in PCI chipset -- module vs. compiled-in
Message-ID: <20060208043728.GA3357@node1.opengeometry.net>
Mail-Followup-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
References: <20060206034312.GA2962@node1.opengeometry.net> <1139200372.2791.208.camel@mindpipe> <1139255365.10437.49.camel@localhost.localdomain> <1139257535.2791.298.camel@mindpipe> <58cb370e0602070014p3d21c8a4u1ca3c5951892cf52@mail.gmail.com> <1139310456.18391.4.camel@localhost.localdomain> <58cb370e0602070314l35b7c88blbe53844939c86f66@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cb370e0602070314l35b7c88blbe53844939c86f66@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2006 at 12:14:09PM +0100, Bartlomiej Zolnierkiewicz wrote:
> On 2/7/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > On Maw, 2006-02-07 at 09:14 +0100, Bartlomiej Zolnierkiewicz wrote:
> > > * chipset specific driver
> > >
> > > The most common mistake is to built-in ide-generic driver
> > > and compile chipset specific driver as module...
> >
> > Oh that no longer works. That worked in 2.4, as it would take over the
> > chipset. Didn't work if it was in use at the time but did work correctly
> > if idle.
> 
> I'm talking about _driver_ here and it works just fine.
> 
> If you are talking about "taking over" feature, you are right.
> It was racy and indeed "worked" depending on timing.

Interesting.  I'll move the "generic" as module, and see how it goes.

-- 
William Park <opengeometry@yahoo.ca>, Toronto, Canada
ThinFlash: Linux thin-client on USB key (flash) drive
	   http://home.eol.ca/~parkw/thinflash.html
BashDiff: Super Bash shell
	  http://freshmeat.net/projects/bashdiff/
