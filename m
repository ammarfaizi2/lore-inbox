Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263314AbTDVRxh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 13:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263315AbTDVRxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 13:53:36 -0400
Received: from air.nwconx.net ([216.211.26.26]:59397 "EHLO air.on.ca")
	by vger.kernel.org with ESMTP id S263314AbTDVRxf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 13:53:35 -0400
From: Garrett Kajmowicz <gkajmowi@tbaytel.net>
Reply-To: gkajmowi@tbaytel.net
Organization: Garrett Kajmowicz
To: Stephan von Krawczynski <skraw@ithnet.com>
Subject: Re: 2.4.20 Kernel panic in IDE-SCSI with CDROM drive
Date: Tue, 22 Apr 2003 14:07:27 -0400
User-Agent: KMail/1.5
References: <200304212137.54302.gkajmowi@tbaytel.net> <20030422123641.7c2fa19d.skraw@ithnet.com>
In-Reply-To: <20030422123641.7c2fa19d.skraw@ithnet.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304221407.27242.gkajmowi@tbaytel.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On April 22, 2003 06:36 am, you wrote:
> This BUG is fixed. Please have a look at the 2.4.21-rc1 ide-scsi patch I
> posted to LKML lately.

I have tested the patch you provided - it did not apply properly so I made the 
changes manually.  Everything now works great!

For the record, it is working on Athlon-xp, only IDE system (with ide-scsi 
emulation), 0.9.2 ALSA drivers and NVidia 1.0-4191 drivers.

Thanks for the help.

>
> On Mon, 21 Apr 2003 21:37:54 -0400
>
> Garrett Kajmowicz <gkajmowi@tbaytel.net> wrote:
> > I recieved the appened kernel oops while attempting to mount a cdrom, as
> > well
> >
> > as to dd the CDROM into a file.  This as occured under 2.4.19 as well as
> > 2.4.20 (reason why I tried upgrading).  The drive is bootable and works
> > fine under Win98.
> >
> > The oops in question locks the system up completely and causes
> > Caps+Scroll lock lights to blink.
> >
> > The drive in question is an HP CD-RW drive, attached via IDE using
> > IDE-SCSI. I have also attached information on my drive, should it be
> > useful.
> >
> > Thank you for all of yuor hard work.  Let me know if you need more info.
> > Garrett Kajmowicz
> > gkajmowi@tbayel.net
> >

<snip>
