Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267617AbUG3FtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267617AbUG3FtO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 01:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267614AbUG3FtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 01:49:14 -0400
Received: from peabody.ximian.com ([130.57.169.10]:20669 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S267617AbUG3FtL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 01:49:11 -0400
Subject: Re: Recent 2.6 kernels can't read an entire ATAPI CD or DVD
From: Robert Love <rml@ximian.com>
To: Jens Axboe <axboe@suse.de>
Cc: "Bryan O'Sullivan" <bos@serpentine.com>,
       Arjan van de Ven <arjanv@redhat.com>, Dave Jones <davej@redhat.com>,
       Edward Angelo Dayao <edward.dayao@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040729084928.GR10377@suse.de>
References: <1090989052.3098.6.camel@camp4.serpentine.com>
	 <20040728053107.GB11690@suse.de>
	 <c93051e8040727235123a6ed67@mail.gmail.com>
	 <20040728065319.GD11690@suse.de> <20040728145228.GA9316@redhat.com>
	 <20040728145543.GB18846@devserv.devel.redhat.com>
	 <20040728163353.GJ10377@suse.de> <20040728170507.GK10377@suse.de>
	 <1091051858.13651.1.camel@camp4.serpentine.com>
	 <20040729084928.GR10377@suse.de>
Content-Type: text/plain
Date: Fri, 30 Jul 2004 01:49:13 -0400
Message-Id: <1091166553.1982.9.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.90 (1.5.90-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-07-29 at 10:49 +0200, Jens Axboe wrote:

> Looks pretty perfect, maybe it's read-ahead screwing it up. Try if
> setting hdparm -a0 /dev/hdc makes a difference.

I am seeing similar errors[1] on later 2.6, too, with about 50% of my
audio CD collection.  Some work, some do not.  I see no pattern.

Already tried disabling read-ahead, does not matter.  Also tried a
different drive.

	Robert Love

[1] 
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54
end_request: I/O error, dev hdc, sector 8
Buffer I/O error on device hdc, logical block 1
...

