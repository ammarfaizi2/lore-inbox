Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267330AbUHMT2L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267330AbUHMT2L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 15:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267327AbUHMT2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 15:28:10 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:53442 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266916AbUHMTZb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 15:25:31 -0400
Message-ID: <9ac707cb040813122522d4a71@mail.gmail.com>
Date: Fri, 13 Aug 2004 15:25:30 -0400
From: Peter Jones <pmjones@gmail.com>
To: Kai Makisara <kai.makisara@kolumbus.fi>
Subject: Re: SG_IO and security
Cc: Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0408122216300.4586@kai.makisara.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1092313030.21978.34.camel@localhost.localdomain>
 <Pine.LNX.4.58.0408120929360.1839@ppc970.osdl.org>
 <Pine.LNX.4.58.0408120943210.1839@ppc970.osdl.org> <411BA0F4.9060201@pobox.com>
 <Pine.LNX.4.58.0408120958000.1839@ppc970.osdl.org> <Pine.LNX.4.58.0408122216300.4586@kai.makisara.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Aug 2004 22:22:36 +0300 (EEST), Kai Makisara
<kai.makisara@kolumbus.fi> wrote:
> On Thu, 12 Aug 2004, Linus Torvalds wrote:
> > Let's see now:
> >
> >       brw-rw----    1 root     disk       3,   0 Jan 30  2003 /dev/hda
> >
> > would you put people you don't trust with your disk in the "disk" group?
> > 
> This protects disks in practice but SG_IO is currently supported by other
> devices, at least SCSI tapes. It is reasonable in some organizations to
> give r/w access to ordinary users so that they can read/write tapes. I
> would be worried if this would enable the users, for instance, to mess up
> the mode page contents of the drive or change the firmware.

Sure, but for that we need command based filtering.

This is at least a step in the right direction.
