Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965072AbVIADrn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965072AbVIADrn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 23:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965073AbVIADrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 23:47:43 -0400
Received: from xenotime.net ([66.160.160.81]:55484 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S965072AbVIADrm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 23:47:42 -0400
Date: Wed, 31 Aug 2005 20:47:41 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: jeff shia <tshxiayu@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sr device can be written?
Message-Id: <20050831204741.397c7845.rdunlap@xenotime.net>
In-Reply-To: <7cd5d4b405083004072c30dffd@mail.gmail.com>
References: <c3c37c55050829215355bb85f4@mail.gmail.com>
	<20050830080812.GA13394@localhost.localdomain>
	<7cd5d4b40508300111260d6b9a@mail.gmail.com>
	<20050830095359.GA15431@localhost.localdomain>
	<7cd5d4b405083004072c30dffd@mail.gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Aug 2005 19:07:55 +0800 jeff shia wrote:

> but It seems that I can not open sr0 with openflags O_RDWR,why?
> open("/dev/sr0",O_RDWR);
> 
> It says:sr0 is a read only file sytem.
> why?

What media did you have in the drive?

For me, with a CD-ROM, I get the same that you reported,
but with a DVD+RW disc, it opens successfully.


> On 8/30/05, Tino Keitel <tino.keitel@gmx.de> wrote:
> > On Tue, Aug 30, 2005 at 16:11:58 +0800, jeff shia wrote:
> > > YOu mean the device file can be written?
> > 
> > Yes, like an ordinary block device.
> > 
> > >
> > >
> > > On 8/30/05, Tino Keitel <tino.keitel@gmx.de> wrote:
> > > > On Tue, Aug 30, 2005 at 12:53:51 +0800, jeff shia wrote:
> > > > > Hello,
> > > > >  Sr is the Scsi-cdrom device?so it can be read only?but look at the source=
> > > > > =20
> > > > > code I notice that
> > > > > sr can be written also!Is it right?
> > > >
> > > > Just imagine a DVD-RAM drive.
> > > >
> > > > Regards,
> > > > Tino
> > > > -

---
~Randy
