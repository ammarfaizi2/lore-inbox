Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263793AbRFSFn1>; Tue, 19 Jun 2001 01:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263854AbRFSFnR>; Tue, 19 Jun 2001 01:43:17 -0400
Received: from mcp.csh.rit.edu ([129.21.60.9]:45831 "EHLO mcp.csh.rit.edu")
	by vger.kernel.org with ESMTP id <S263793AbRFSFnD>;
	Tue, 19 Jun 2001 01:43:03 -0400
Date: Tue, 19 Jun 2001 01:37:30 -0400
From: Jeff Mahoney <jeffm@suse.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Shawn Starr <spstarr@sh0n.net>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.6-pre3 breaks ReiserFS mount on boot
Message-ID: <20010619013729.I8295@fury.csh.rit.edu>
In-Reply-To: <Pine.LNX.4.30.0106182320510.2168-100000@coredump.sh0n.net> <Pine.LNX.4.30.0106182355500.118-100000@coredump.sh0n.net> <20010619010633.G8295@fury.csh.rit.edu> <15150.58266.85737.742044@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <15150.58266.85737.742044@notabene.cse.unsw.edu.au>; from neilb@cse.unsw.edu.au on Tue, Jun 19, 2001 at 03:31:06PM +1000
X-Operating-System: SunOS 5.8 (sun4u)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2001 at 03:31:06PM +1000, Neil Brown wrote:
> On Tuesday June 19, jeffm@suse.com wrote:
> > On Mon, Jun 18, 2001 at 11:57:16PM -0400, Shawn Starr wrote:
> > > 
> > > read_super_block: can't find a reiserfs filesystem on dev 03:42
> > > read_old_super_block: try to find super block in old location
> > > read_old_super_block: can't find a reiserfs filesystem on dev 03:42
> > > Kernel Panic: VFS: Unable to mount root fs on 03:42
> > > 
> > > my super block broke somewhere?
> > 
> >     Out of curiousity, what device are you trying to boot from? 03:42, at least
> >     according to linux/Documentation/devices.txt, corresponds to /dev/hda42.
> 
> or, noting that kdevname used hexadecimal, 
>   /dev/hdb2

    Ugh. Ignore me, I should've known that.

    -Jeff

-- 
Jeff Mahoney
jeffm@suse.com
jeffm@csh.rit.edu
