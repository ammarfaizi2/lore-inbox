Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263746AbRFSFdQ>; Tue, 19 Jun 2001 01:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263749AbRFSFdG>; Tue, 19 Jun 2001 01:33:06 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:12300 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S263746AbRFSFcs>; Tue, 19 Jun 2001 01:32:48 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Jeff Mahoney <jeffm@suse.com>
Date: Tue, 19 Jun 2001 15:31:06 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15150.58266.85737.742044@notabene.cse.unsw.edu.au>
Cc: Shawn Starr <spstarr@sh0n.net>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.6-pre3 breaks ReiserFS mount on boot
In-Reply-To: message from Jeff Mahoney on Tuesday June 19
In-Reply-To: <Pine.LNX.4.30.0106182320510.2168-100000@coredump.sh0n.net>
	<Pine.LNX.4.30.0106182355500.118-100000@coredump.sh0n.net>
	<20010619010633.G8295@fury.csh.rit.edu>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday June 19, jeffm@suse.com wrote:
> On Mon, Jun 18, 2001 at 11:57:16PM -0400, Shawn Starr wrote:
> > 
> > read_super_block: can't find a reiserfs filesystem on dev 03:42
> > read_old_super_block: try to find super block in old location
> > read_old_super_block: can't find a reiserfs filesystem on dev 03:42
> > Kernel Panic: VFS: Unable to mount root fs on 03:42
> > 
> > my super block broke somewhere?
> 
>     Out of curiousity, what device are you trying to boot from? 03:42, at least
>     according to linux/Documentation/devices.txt, corresponds to /dev/hda42.

or, noting that kdevname used hexadecimal, 
  /dev/hdb2

NeilBrown

> 
>     Is that really the disk you're trying to mount? I'm not familiar with how
>     some IDE RAID controllers present disks, but it was the first thing I
>     noticed.
> 
>     -Jeff
> 
> -- 
> Jeff Mahoney
> jeffm@suse.com
> jeffm@csh.rit.edu
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
