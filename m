Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264383AbTL3Ebc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 23:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264405AbTL3Ebc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 23:31:32 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:32396 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S264383AbTL3Eb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 23:31:27 -0500
Date: Mon, 29 Dec 2003 08:07:28 -0500
From: Willem Riede <wrlk@riede.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: The survival of ide-scsi in 2.6.x
Message-ID: <20031229130728.GW1277@linnie.riede.org>
Reply-To: wrlk@riede.org
References: <mailman.1072462764.22951.linux-kernel2news@redhat.com> <200312290457.hBT4vJFj006089@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <200312290457.hBT4vJFj006089@devserv.devel.redhat.com> (from zaitcev@redhat.com on Sun, Dec 28, 2003 at 23:57:19 -0500)
X-Mailer: Balsa 2.0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2003.12.28 23:57, Pete Zaitcev wrote:
> > I need ide-scsi to survive. Why? I maintain osst, a driver for
> > OnStream tape drives, which need special handling. These drives
> > exist in SCSI, ATAPI, USB and IEEE1394 versions.
> 
> > One high-level driver, osst, handles all of them, and that's how
> > it should be, right? For ATAPI, it relies on ide-scsi.
> > 
> > (By the way, ide-tape contains code for the ATAPI version, the 
> > DI-30, but that code is old and has serveral known problems - 
> > I'd like to see it removed - or at least deprecated - I will do 
> > that myself later if people want me to.)
> 
> Based on my expirience with ide-tape, I would rather have it
> killed instead. One neat trick to appease enemies of ide-scsi
> might be to rename it into ide-scsi into ide-tape-bis.
> Might even add DSC bit handling... But the ide-tape is too
> ugly to live for sure.

I would agree, but would that get any people in trouble? That is,
are there any IDE tape drives currently supported by ide-tape, 
that are not compatble with ide-scsi plus st?

Thanks, Willem Riede.
