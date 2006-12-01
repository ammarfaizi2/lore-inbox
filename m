Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162150AbWLAWmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162150AbWLAWmp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 17:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162151AbWLAWmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 17:42:45 -0500
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:41434 "EHLO
	mtaout01-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1162150AbWLAWmo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 17:42:44 -0500
Date: Fri, 1 Dec 2006 22:42:40 +0000
From: Ken Moffat <zarniwhoop@ntlworld.com>
To: linux-kernel@vger.kernel.org
Subject: Re: CD oddities with VIA PATA
Message-ID: <20061201224240.GB22909@deepthought.linux.bogus>
References: <20061201220134.GA22909@deepthought.linux.bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20061201220134.GA22909@deepthought.linux.bogus>
User-Agent: Mutt/1.5.11
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2006 at 10:01:34PM +0000, Ken Moffat wrote:
> 
> (i.) cdparanoia (9.8) works for root, but for a user it complains
> that the ioctl isn't cooked and refuses to run.  For test purposes,
> it runs ok for a user as suid root, but I imagine that increases
> the likelihood of unspeakable things happening.  (Fortunately, I
> don't have a dachshund)
> 
 Forgot to mention the lines in the log from cdparanoia, but I think
these frequent messages are expected:

Dec  1 20:35:53 ac30 kernel: sg_write: data in/out 30576/30576 bytes for SCSI command 0xbe--guessing data in;
Dec  1 20:35:53 ac30 kernel:    program cdparanoia not setting count and/or reply_len properly

 Also forgot the details of the drive, just in case

Dec  1 19:17:14 ac30 kernel: scsi3 : pata_via
Dec  1 19:17:14 ac30 kernel: ata4.00: ATAPI, max UDMA/66
Dec  1 19:17:14 ac30 kernel: Losing some ticks... checking if CPU frequency changed.
Dec  1 19:17:14 ac30 kernel: ata4.00: configured for UDMA/66
Dec  1 19:17:14 ac30 kernel: scsi 3:0:0:0: CD-ROM            LITE-ON DVDRW SHW-1635S  YS0G PQ: 0 ANSI: 5
Dec  1 19:17:14 ac30 kernel: sr0: scsi3-mmc drive: 48x/48x writer cd/rw xa/form2 cdda tray
Dec  1 19:17:14 ac30 kernel: Uniform CD-ROM driver Revision: 3.20
Dec  1 19:17:14 ac30 kernel: sr 3:0:0:0: Attached scsi CD-ROM sr0
Dec  1 19:17:14 ac30 kernel: sr 3:0:0:0: Attached scsi generic sg1 type 5

Ken
-- 
das eine Mal als Tragödie, das andere Mal als Farce
