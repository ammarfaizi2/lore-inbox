Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276628AbRJKSFU>; Thu, 11 Oct 2001 14:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276633AbRJKSFK>; Thu, 11 Oct 2001 14:05:10 -0400
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:30280 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S276628AbRJKSEw>; Thu, 11 Oct 2001 14:04:52 -0400
Date: Thu, 11 Oct 2001 20:03:49 +0200
From: Christian Ullrich <chris@chrullrich.de>
To: linux-kernel@vger.kernel.org
Cc: reiserfs-list@namesys.com
Subject: Re: [reiserfs-list] Can't mount reiserfs with 2.4.11, 2.4.10 works fine
Message-ID: <20011011200349.A3818@christian.chrullrich.de>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	reiserfs-list@namesys.com
In-Reply-To: <20011011061239.A990@christian.chrullrich.de> <3BC55363.ABE2813B@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.16i
In-Reply-To: <3BC55363.ABE2813B@namesys.com>; from vs@namesys.com on Thu, Oct 11, 2001 at 12:08:03PM +0400
X-Current-Uptime: 0 d, 14:11:05 h
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Vladimir V. Saveliev wrote on Thursday, 2001-10-11:

> Christian Ullrich wrote:

> > After upgrading from 2.4.10 to 2.4.11, I can no longer
> > mount one particular reiserfs; everything else works fine.
> > The reiserfs in question uses the 3.6 disk format.
> >
> > I get the following messages in syslog:
> >
> > kernel: hdb6: bad access: block=128, count=2
> > kernel: end_request: I/O error, dev 03:46 (hdb), sector 128
> > kernel: read_super_block: bread failed (dev 03:46, block 64, size 1024)
> > kernel: hdb6: bad access: block=16, count=2
> > kernel: end_request: I/O error, dev 03:46 (hdb), sector 16
> > kernel: read_super_block: bread failed (dev 03:46, block 8, size 1024)
> >
> > With 2.4.10, there is no problem, neither before nor after
> > 2.4.11 failed.

> http://www.kernel.org/pub/linux/kernel/v2.4/ChangeLog-2.4.11 says that pre1 and
> pre2 got some block device changes. Although I am not sure they made block
> device driver less persistent.
> Have you tried to run badblocks under 2.4.10 and 2.4.11?

I just did under 2.4.10. No trouble at all.

> Anyway, I would not trust to this hard drive too much.

I tend to trust it. It is not even six months old and has worked
flawlessly until now. And with kernel 2.4.10, it continues to work
flawlessly.
Sure, the messages look a lot like hardware failures. But I think
earlier kernel versions would tell me about hardware read errors 
as well, even if they can correct them.

-- 
Christian Ullrich		     Registrierter Linux-User #125183

"Sie können nach R'ed'mond fliegen -- aber Sie werden sterben"
