Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281320AbRKMAm7>; Mon, 12 Nov 2001 19:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281297AbRKMAmu>; Mon, 12 Nov 2001 19:42:50 -0500
Received: from mail.cb.monarch.net ([24.244.11.6]:48146 "EHLO
	baca.cb.monarch.net") by vger.kernel.org with ESMTP
	id <S281298AbRKMAme>; Mon, 12 Nov 2001 19:42:34 -0500
Date: Mon, 12 Nov 2001 17:40:05 -0700
From: "Peter J . Braam" <braam@clusterfilesystem.com>
To: Andrew Morton <akpm@zip.com.au>, Steve Lord <lord@sgi.com>,
        Ben Israel <ben@genesis-one.com>, linux-kernel@vger.kernel.org,
        "Peter J . Braam" <braam@clusterfilesystem.com>
Subject: Re: File System Performance
Message-ID: <20011112174005.N4281@lustre.dyn.ca.clusterfilesystem.com>
In-Reply-To: <3BF02702.34C21E75@zip.com.au>, <00b201c16b81$9d7aaba0$5101a8c0@pbc.adelphia.net> <3BEFF9D1.3CC01AB3@zip.com.au> <00da01c16ba2$96aeda00$5101a8c0@pbc.adelphia.net> <3BF02702.34C21E75@zip.com.au> <1005595583.13307.5.camel@jen.americas.sgi.com> <3BF03402.87D44589@zip.com.au> <20011112171705.Z1778@lynx.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011112171705.Z1778@lynx.no>; from adilger@turbolabs.com on Mon, Nov 12, 2001 at 05:17:05PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The KML in fact doesn't record the writes.  I don't have a large KML,
but it is easy to set one up.  Let me know if you need a hand.

- Peter -

On Mon, Nov 12, 2001 at 05:17:05PM -0700, Andreas Dilger wrote:
> On Nov 12, 2001  12:41 -0800, Andrew Morton wrote:
> > BTW, I've been trying to hunt down a suitable file system aging tool.
> > We're not very happy with Keith Smith's workload because the directory
> > infomation was lost (he was purely studying FFS algorithmic differences
> > - the load isn't 100% suitable for testing other filesystems / algorithms).
> >   Constantin Loizides' tools are proving to be rather complex to compile,
> >   drive and understand.
> 
> What _may_ be a very interesting tool for doing "real-world" I/O generation
> is to use the InterMezzo KML (kernel modification log), which is basically
> a 100% record of every filesystem operation done (e.g. create, write,
> delete, mkdir, rmdir, etc).
> 
> Peter, do you have any very large KML files which would simulate the usage
> of a filesystem over a long period of time, or would Tacitus have something
> like that?
> 
> Cheers, Andreas
> --
> Andreas Dilger
> http://sourceforge.net/projects/ext2resize/
> http://www-mddsp.enel.ucalgary.ca/People/adilger/
> 

-- 
