Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283001AbRK1Bvx>; Tue, 27 Nov 2001 20:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281852AbRK1Bvn>; Tue, 27 Nov 2001 20:51:43 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:18048 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S281857AbRK1Bv2>; Tue, 27 Nov 2001 20:51:28 -0500
Date: Tue, 27 Nov 2001 18:55:09 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Jens Axboe <axboe@suse.de>,
        linux-kernel@vger.kernel.org, jmerkey@timpanogas.org
Subject: Re: Block I/O Enchancements, 2.5.1-pre2
Message-ID: <20011127185509.A1060@vger.timpanogas.org>
In-Reply-To: <15364.3457.368582.994067@gargle.gargle.HOWL> <Pine.LNX.4.33.0111271701140.1629-100000@penguin.transmeta.com> <20011127183418.A812@vger.timpanogas.org> <3C0441B4.B8194BEE@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C0441B4.B8194BEE@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Tue, Nov 27, 2001 at 08:45:24PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2001 at 08:45:24PM -0500, Jeff Garzik wrote:
> "Jeff V. Merkey" wrote:
> > 1.  The changes made to submit_bh indicate I can now send long
> > chains of variable block size requests to the I/O layer similiar
> > to the capability of Windows 2000 and NetWare I/O subsystems.
> 
> I don't want to speak for either Jens or Linus, but from what Jens was
> telling me months ago, and from my reading of Jens' earlier patches,
> this seems to indeed be the case.  I've been looking forward to sending
> non-block-sized I/Os to and from a new filesystem I'm working on.
> 
> 
> > 3.  In theory, I should be able to support page cache capability
> > for NWFS and possibly NTFS in Linux the way these wierd non-Unix
> > OS's work.
> 
> If you are hacking on NTFS please make sure to base changes on
> "ntfs-driver-tng" in the "linux-ntfs" sourceforge cvs.  It is now, as of
> the past week, completely modern to 2.4 vfs standards, and should
> support all read-only features except attribute lists.

I have a version that supports everything, including the journal, 
and does not "barf" on writes.  Unfortunately it's written in 
"merkey code style" which is ThoseF_ckingLongAssNamesForEveryDamnFunction()
I was trained to write at Novell.   Merging it into the sourceforge
version will be nasty.  I have a few other projects and code I 
am tardy in sending to Brazil :-).  I think just letting Anton
review some of it may be a better approach.  NWFS is first 
up and needs to get finished and in so if I get hit by 
a truck or killed by a deranged Novell employee who has 
been recently laid off, someone can take maintain it.

:-)

Jeff

> 
> Regards,
> 
> 	Jeff




> 
> 
> -- 
> Jeff Garzik      | Only so many songs can be sung
> Building 1024    | with two lips, two lungs, and one tongue.
> MandrakeSoft     |         - nomeansno
