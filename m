Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264115AbTFHAnG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 20:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264146AbTFHAnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 20:43:05 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:39465 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264115AbTFHAnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 20:43:04 -0400
Date: Sat, 7 Jun 2003 17:56:49 -0700
From: Andrew Morton <akpm@digeo.com>
To: Alexander Hoogerhuis <alexh@ihatent.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Christoph Hellwig <hch@lst.de>
Subject: Re: 2.5.70-mm6
Message-Id: <20030607175649.6bf3813b.akpm@digeo.com>
In-Reply-To: <873cilz9os.fsf@lapper.ihatent.com>
References: <20030607151440.6982d8c6.akpm@digeo.com>
	<873cilz9os.fsf@lapper.ihatent.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Jun 2003 00:56:40.0220 (UTC) FILETIME=[D22025C0:01C32D58]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Hoogerhuis <alexh@ihatent.com> wrote:
>
> Andrew Morton <akpm@digeo.com> writes:
> >
> > [SNIP]
> >
> 
> It builds nicely here and runs nicely so far, but my USB-drive still
> blows up after a few gigs

Is that usb-storage?  There seem to have been a few reports of
erratic behaviour lately.

> and I have this one when plugging it in:
> 
> Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
> spurious 8259A interrupt: IRQ7.
> SCSI device sda: 490232832 512-byte hdwr sectors (250999 MB)
> sda: cache data unavailable
> sda: assuming drive cache: write through
>  /dev/scsi/host0/bus0/target0/lun0: p1
> devfs_mk_dir(scsi/host0/bus0/target0/lun0): could not append to dir: ea549820 "target0"

Maybe Christph can decode this one for us.


