Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293334AbSBYPyl>; Mon, 25 Feb 2002 10:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293325AbSBYPyc>; Mon, 25 Feb 2002 10:54:32 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:30709
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S292484AbSBYPyY>; Mon, 25 Feb 2002 10:54:24 -0500
Date: Mon, 25 Feb 2002 07:54:52 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Ed Sweetman <ed.sweetman@wmich.edu>
Cc: Fran?ois Cami <stilgar2k@wanadoo.fr>, "J.A. Magallon" <jamagallon@able.es>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHSET] Linux 2.4.18-rc4-jam1
Message-ID: <20020225155452.GT20060@matchmail.com>
Mail-Followup-To: Ed Sweetman <ed.sweetman@wmich.edu>,
	Fran?ois Cami <stilgar2k@wanadoo.fr>,
	"J.A. Magallon" <jamagallon@able.es>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020223234217.C2023@werewolf.able.es> <3C782531.6050701@wanadoo.fr> <1014514801.492.14.camel@psuedomode> <1014516072.491.28.camel@psuedomode> <20020224030620.GR20060@matchmail.com> <1014526676.587.29.camel@psuedomode>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1014526676.587.29.camel@psuedomode>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 23, 2002 at 11:57:51PM -0500, Ed Sweetman wrote:
> On Sat, 2002-02-23 at 22:06, Mike Fedyk wrote:
> > On Sat, Feb 23, 2002 at 09:01:06PM -0500, Ed Sweetman wrote:
> > > Or it could be my ext3 fs corrupting files again.
> > > 
> > 
> > Oy, do you have one of those write-back (behind) ide hard drives?

> Probably, it's a WD 100GB.  hdparm says   WriteCache=enabled
> I dont know if the bios is set to writeback off hand, I'd have to
> reboot, which I'll probably do soon to add in another hdd and possibly
> run memtest86 instead of just memtest

Does it turn off automatically on shutdown (halt)?

Debian has recently turned off write-back caching on shutdown just after
unmounting all local filesystems.  That, or turning off write-back caching
will probably fix your problem.

Mike
