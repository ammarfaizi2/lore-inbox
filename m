Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264104AbTLOScb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 13:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263969AbTLOSca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 13:32:30 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:28293
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264104AbTLOSa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 13:30:56 -0500
Date: Mon, 15 Dec 2003 19:31:38 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Sergey Vlasov <vsu@altlinux.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC - tarball/patch server in BitKeeper
Message-ID: <20031215183138.GJ6730@dualathlon.random>
References: <20031214172156.GA16554@work.bitmover.com> <2259130000.1071469863@[10.10.2.4]> <20031215151126.3fe6e97a.vsu@altlinux.ru> <20031215132720.GX7308@phunnypharm.org> <20031215192402.528ce066.vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031215192402.528ce066.vsu@altlinux.ru>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 15, 2003 at 07:24:02PM +0300, Sergey Vlasov wrote:
> On Mon, 15 Dec 2003 08:27:20 -0500 Ben Collins wrote:
> 
> > On Mon, Dec 15, 2003 at 03:11:26PM +0300, Sergey Vlasov wrote:
> > > I see another missing feature - there does not seem to be a way to
> > > order the changesets by the order of merging them into the tree. E.g.
> > > when you look at the linux-2.4 changesets, you will now find XFS all
> > > over the place - even before 2.4.23, while it really has been merged
> > > after 2.4.23.
> > 
> > You don't seem to understand how bitkeeper works then. Back when the XFS
> > tree was cloned from the 2.4 tree, it began it's own "branch". Over time
> > it has merged code from the 2.4 tree, and it's work has occured over
> > this same time.
> > 
> > When XFS was merged back into the 2.4 tree, it retains all of that
> > history in sort of a split road looking branch/merge.
> 
> Keeping that history is good. But the main 2.4 branch also has its own
> history - and it shows that there were no XFS code in that branch up
> to and including 2.4.23.
> 
> There does not seem to be a way to get this information - at least
> through bkbits.net.

you get the 2.4 branch linear history via bkcvs. Though there you lose
all the granular xfs development changesets instead, the xfs merge
becames a huge monolithic patch see below.  Either way or another you
lose information compared to true BK. From my part I'm fine with the
info provided in bkcvs, I'm only correcting Larry statement about him
providing lots of way to get at the data in a interoperable protocol,
he's only providing _partial_ data in a interoperable way. I'm stating
facts, no whining intendend.


---------------------
PatchSet 4315 
Date: 2003/12/08 10:56:10
Author: marcelo
Branch: HEAD
Tag: (none) 
Log:
Merge http://xfs.org:8090/linux-2.4+justXFS
into logos.cnet:/home/marcelo/bk/linux-2.4

2003/12/07 18:05:50-06:00 cattelan
Merge lips.borg.umn.edu:/export/hose/bkroot/linux-2.4
into lips.borg.umn.edu:/export/music/bkroot/linux-2.4+justXFS

2003/12/07 12:05:42-06:00 cattelan
Merge lips.borg.umn.edu:/export/hose/bkroot/linux-2.4
into lips.borg.umn.edu:/export/music/bkroot/linux-2.4+justXFS

2003/12/07 10:06:25-06:00 cattelan
Merge lips.borg.umn.edu:/export/hose/bkroot/linux-2.4
into lips.borg.umn.edu:/export/music/bkroot/linux-2.4+justXFS

2003/12/07 06:12:25-06:00 cattelan
Merge lips.borg.umn.edu:/export/hose/bkroot/linux-2.4
into lips.borg.umn.edu:/export/music/bkroot/linux-2.4+justXFS

2003/12/06 13:11:32-06:00 cattelan
Merge lips.borg.umn.edu:/export/hose/bkroot/linux-2.4
into lips.borg.umn.edu:/export/music/bkroot/linux-2.4+justXFS

2003/12/05 09:10:59-06:00 cattelan
Merge lips.borg.umn.edu:/export/hose/bkroot/linux-2.4
into lips.borg.umn.edu:/export/music/bkroot/linux-2.4+justXFS

2003/12/05 08:10:27-06:00 cattelan
Merge lips.borg.umn.edu:/export/hose/bkroot/linux-2.4
into lips.borg.umn.edu:/export/music/bkroot/linux-2.4+justXFS

2003/12/05 06:11:17-06:00 cattelan
Merge lips.borg.umn.edu:/export/hose/bkroot/linux-2.4
into lips.borg.umn.edu:/export/music/bkroot/linux-2.4+justXFS

2003/12/03 22:31:56-06:00 cattelan
Gone dmapi

2003/12/03 08:10:37-06:00 cattelan
Merge lips.borg.umn.edu:/export/hose/bkroot/linux-2.4
into lips.borg.umn.edu:/export/music/bkroot/linux-2.4+justXFS

2003/12/03 04:09:22-06:00 cattelan
Merge lips.borg.umn.edu:/export/hose/bkroot/linux-2.4
into lips.borg.umn.edu:/export/music/bkroot/linux-2.4+justXFS

2003/12/03 17:04:05+11:00 nathans
Merge nathans@xfs.org:/export/hose/bkroot/linux-2.4+justXFS
into bruce.melbourne.sgi.com:/source1/linux-2.4+justXFS

2003/12/03 17:01:12+11:00 nathans
[XFS] Fix comment in xfs_rename.c

SGI Modid: xfs-linux:slinx:162760a

2003/12/03 16:56:07+11:00 nathans
[XFS] Prevent log ktrace code from sleeping in an invalid context.

SGI Modid: xfs-linux:slinx:162768a

2003/12/03 16:51:38+11:00 nathans
[XFS] Use vnode timespec modifiers for atime/mtime/ctime, keeps last code hunk in sync.

SGI Modid: xfs-linux:slinx:162782a

2003/12/02 15:29:17-06:00 cattelan
Merge cattelan@xfs.org:/export/hose/bkroot/linux-2.4+justXFS
into naboo.americas.sgi.com:/go/space/BKpulls/linux-2.4+justXFS

2003/12/02 15:27:16-06:00 cattelan
Merge naboo.americas.sgi.com:/go/space/BKpulls/linux-2.4
into naboo.americas.sgi.com:/go/space/BKpulls/linux-2.4+justXFS

2003/12/02 12:07:27-06:00 cattelan
Merge lips.borg.umn.edu:/export/hose/bkroot/linux-2.4
into lips.borg.umn.edu:/export/hose/bkroot/linux-2.4+justXFS

2003/12/02 10:56:27-06:00 cattelan
Merge cattelan@xfs.org:/export/hose/bkroot/linux-2.4+justXFS
into naboo.americas.sgi.com:/go/space/BKpulls/linux-2.4+justXFS

2003/12/02 10:55:00-06:00 cattelan
Merge naboo.americas.sgi.com:/go/space/BKpulls/linux-2.4
into naboo.americas.sgi.com:/go/space/BKpulls/linux-2.4+justXFS

2003/12/02 09:10:50-06:00 cattelan
Merge lips.borg.umn.edu:/export/hose/bkroot/linux-2.4
into lips.borg.umn.edu:/export/hose/bkroot/linux-2.4+justXFS

2003/12/02 08:09:28-06:00 cattelan
Merge lips.borg.umn.edu:/export/hose/bkroot/linux-2.4
into lips.borg.umn.edu:/export/hose/bkroot/linux-2.4+justXFS

2003/12/01 14:12:40-06:00 cattelan
Merge lips.borg.umn.edu:/export/hose/bkroot/linux-2.4
into lips.borg.umn.edu:/export/hose/bkroot/linux-2.4+justXFS

2003/12/01 10:59:59-06:00 cattelan
Merge cattelan@xfs.org:/export/hose/bkroot/linux-2.4+justXFS
into naboo.americas.sgi.com:/go/space/BKpulls/linux-2.4+justXFS

2003/12/01 10:58:16-06:00 cattelan
Merge naboo.americas.sgi.com:/go/space/BKpulls/linux-2.4
into naboo.americas.sgi.com:/go/space/BKpulls/linux-2.4+justXFS

2003/12/01 10:36:38+11:00 nathans
[XFS] Remove some unused pagebuf source and header files.

2003/12/01 10:21:09+11:00 nathans
[XFS] Add the noikeep mount option, make ikeep the default for now.

SGI Modid: xfs-linux:slinx:162621a

2003/12/01 10:05:21+11:00 nathans
[XFS] Update the way we hook into the generic direct IO code so we share more code.  This means we no longer need to dup remove_suid within xfs_write_clear_setuid.

SGI Modid: xfs-linux:slinx:162446a

2003/12/01 09:59:33+11:00 nathans
[XFS] Convert to revised kmem shake interface.

SGI Modid: xfs-linux:slinx:162426a

2003/12/01 09:56:21+11:00 nathans
[XFS] Use a kmem shaking interface for 2.4 which is much more like the 2.6 one.

SGI Modid: xfs-linux:slinx:162377a

2003/11/30 12:06:55-06:00 cattelan
Merge lips.borg.umn.edu:/export/hose/bkroot/linux-2.4
into lips.borg.umn.edu:/export/hose/bkroot/linux-2.4+justXFS

2003/11/25 15:20:10-06:00 cattelan
Merge lips.borg.umn.edu:/export/hose/bkroot/linux-2.4
into lips.borg.umn.edu:/export/hose/bkroot/linux-2.4+justXFS

2003/11/24 15:08:28-06:00 cattelan
Merge lips.thebarn.com:/export/hose/bkroot/linux-2.4
into lips.thebarn.com:/export/hose/bkroot/linux-2.4+justXFS

2003/11/24 11:52:28-06:00 cattelan
Merge cattelan@xfs.org:/export/hose/bkroot/linux-2.4+justXFS
into naboo.americas.sgi.com:/go/space/BKpulls/linux-2.4+justXFS

2003/11/24 11:50:51-06:00 cattelan
Merge naboo.americas.sgi.com:/go/space/BKpulls/linux-2.4
into naboo.americas.sgi.com:/go/space/BKpulls/linux-2.4+justXFS

2003/11/24 11:42:12-06:00 nathans
[XFS] Fix some incorrect debug code after buftarg changes.

SGI Modid: xfs-linux:slinx:162334a

2003/11/24 11:41:29-06:00 nathans
[XFS] Abstract out the current_time interface use from quota to support multiple kernel versions.

SGI Modid: xfs-linux:slinx:162333a

2003/11/24 11:40:40-06:00 nathans
[XFS] Switch debug quota code to use xfs_buftarg interface instead of dev_t

SGI Modid: xfs-linux:slinx:162332a

2003/11/24 11:39:45-06:00 nathans
[XFS] Use xfs_statfs type to statfs operation, to support multiple kernels more easily.

SGI Modid: xfs-linux:slinx:162330a

2003/11/24 11:38:45-06:00 nathans
[XFS] Abstract sendfile operation out, supporting multiple kernels more easily.

SGI Modid: xfs-linux:slinx:162328a

2003/11/24 11:37:46-06:00 nathans
[XFS] Use iomap abstraction consistently.

SGI Modid: xfs-linux:slinx:162327a

2003/11/24 11:36:05-06:00 nathans
[XFS] Merge find_next_zero_bit casting fixes back from 2.6 code

SGI Modid: xfs-linux:slinx:162321a

2003/11/24 11:35:16-06:00 nathans
[XFS] Switch from using dev_t to xfs_buftarg_t for representing the devices underneath XFS

SGI Modid: xfs-linux:slinx:162319a

2003/11/24 11:34:23-06:00 nathans
[XFS] Move the stack trace wrapper into a kernel-version-specific location.

SGI Modid: xfs-linux:slinx:162318a

2003/11/24 11:05:44-06:00 cattelan
Merge lips.thebarn.com:/export/hose/bkroot/linux-2.4
into lips.thebarn.com:/export/hose/bkroot/linux-2.4+justXFS

2003/11/24 06:06:26-06:00 cattelan
Merge lips.thebarn.com:/export/hose/bkroot/linux-2.4
into lips.thebarn.com:/export/hose/bkroot/linux-2.4+justXFS

2003/11/22 08:05:41-06:00 cattelan
Merge lips.thebarn.com:/export/hose/bkroot/linux-2.4
into lips.thebarn.com:/export/hose/bkroot/linux-2.4+justXFS

2003/11/21 15:50:01-06:00 sandeen
[XFS] Fix the pb stats clear handler, value is
int but handler was using ulong

SGI Modid: xfs-linux:slinx:162287a

2003/11/21 15:49:13-06:00 sandeen
[XFS] Fix a few sysctls - values are all ints, but
sysctl table was setting up for longs.

SGI Modid: xfs-linux:slinx:162285a

2003/11/21 15:27:01-06:00 cattelan
Merge cattelan@xfs.org:/export/hose/bkroot/linux-2.4+justXFS
into naboo.americas.sgi.com:/go/space/BKpulls/linux-2.4+justXFS

2003/11/21 15:03:14-06:00 cattelan
Merge naboo.americas.sgi.com:/go/space/BKpulls/linux-2.4
into naboo.americas.sgi.com:/go/space/BKpulls/linux-2.4+justXFS

2003/11/21 14:55:34-06:00 nathans
[XFS] Fix build fallout from refcache reorganisation.

2003/11/21 14:53:54-06:00 nathans
[XFS] Fix a build error in some debug code.

SGI Modid: xfs-linux:slinx:162147a

2003/11/21 14:52:47-06:00 nathans
[XFS] Switch to using the BSD qsort implementation.

SGI Modid: xfs-linux:slinx:162158a

2003/11/21 14:51:07-06:00 nathans
[XFS] Trivial/whitespace changes to sync up different trees a bit.

SGI Modid: xfs-linux:slinx:162244a

2003/11/21 14:46:44-06:00 nathans
[XFS] Change pagebuf to use the same ktrace implementation as XFS, instead of reinventing that wheel.

SGI Modid: xfs-linux:slinx:162159a

2003/11/21 14:45:05-06:00 nathans
[XFS] Merge page_buf_locking routines in with the rest of page_buf.

SGI Modid: xfs-linux:slinx:162155a

2003/11/21 14:39:14-06:00 nathans
[XFS] Remove assertion that we do not hold a lock - no lock ownership state available.

SGI Modid: xfs-linux:slinx:162250a

2003/11/21 14:37:03-06:00 nathans
[XFS] Seperate the NFS reference cache code out from xfs_rw.c to simplify management of different kernel versions.

SGI Modid: xfs-linux:slinx:162241a

2003/11/21 11:05:37-06:00 cattelan
Merge lips.thebarn.com:/export/hose/bkroot/linux-2.4
into lips.thebarn.com:/export/hose/bkroot/linux-2.4+justXFS

2003/11/20 13:05:37-06:00 cattelan
Merge lips.thebarn.com:/export/hose/bkroot/linux-2.4
into lips.thebarn.com:/export/hose/bkroot/linux-2.4+justXFS

2003/11/20 10:06:02-06:00 cattelan
Merge lips.thebarn.com:/export/hose/bkroot/linux-2.4
into lips.thebarn.com:/export/hose/bkroot/linux-2.4+justXFS

2003/11/20 08:05:42-06:00 cattelan
Merge lips.thebarn.com:/export/hose/bkroot/linux-2.4
into lips.thebarn.com:/export/hose/bkroot/linux-2.4+justXFS

2003/11/19 11:23:27-06:00 cattelan
[XFS] Add new file ... missed in orginal checkin

SGI Modid: xfs-linux:slinx:162050a

2003/11/19 11:22:20-06:00 cattelan
[XFS] move the iomap data structures out of pagebuf

SGI Modid: xfs-linux:slinx:162048a

2003/11/19 11:20:48-06:00 nathans
[XFS] Move Linux-version specific code out of xfs_iomap.c so that it can become part of the XFS core code.

SGI Modid: xfs-linux:slinx:161995a

2003/11/19 11:19:43-06:00 nathans
[XFS] Backport some trivial changes from the 2.6 code base - page uptodate flag macro name changes

SGI Modid: xfs-linux:slinx:161994a

2003/11/19 11:18:38-06:00 nathans
[XFS] Backport an unmerged bug fix from the 2.6 code base - only submit a convert_page page for IO if startio is set.

SGI Modid: xfs-linux:slinx:161993a

2003/11/19 11:17:32-06:00 nathans
[XFS] Backport an unmerged bug fix from the 2.6 code base - if probe_unmapped_page fails while walking down the unmapped page list, do not attempt to probe the last page as well just return.

SGI Modid: xfs-linux:slinx:161992a

2003/11/19 11:16:27-06:00 nathans
[XFS] Backport minor 2.6 changes to the iomap interface to keep code more in sync.

SGI Modid: xfs-linux:slinx:161987a

2003/11/19 11:15:23-06:00 nathans
[XFS] Backport a couple of debugging changes from the 2.6 code base

SGI Modid: xfs-linux:slinx:161984a

2003/11/19 11:14:22-06:00 nathans
[XFS] Enable pagebuf lock tracking via debug.

SGI Modid: xfs-linux:slinx:161981a

2003/11/19 11:12:41-06:00 sandeen
[XFS] BH_Sync added in 2.4.22, put an #ifdef in for now so this
still works on older kernels.

SGI Modid: xfs-linux:slinx:161964a

2003/11/19 11:10:53-06:00 cattelan
Merge rose.americas.sgi.com:/.amd_mnt/naboo/export/space/BKpulls/linux-2.4
into rose.americas.sgi.com:/.amd_mnt/naboo/export/space/BKpulls/linux-2.4+justXFS

2003/11/17 14:25:45-06:00 cattelan
Merge cattelan@xfs.org:/export/hose/bkroot/linux-2.4+justXFS
into naboo.americas.sgi.com:/go/space/BKpulls/linux-2.4+justXFS

2003/11/17 13:32:57-06:00 sandeen
[XFS] Remove a nested transaction in xfs_dm_punch_hole

SGI Modid: xfs-linux:slinx:161392a

2003/11/17 13:29:55-06:00 sandeen
[XFS] Use buffer head flag set/clear routines as in 2.6
kernel to reduce 2.4/2.6 differences in xfs

SGI Modid: xfs-linux:slinx:161777a

2003/11/17 13:28:35-06:00 sandeen
[XFS] Use i_size_read/i_size_write semantics from 2.6
kernel to reduce 2.4/2.6 differences in xfs

SGI Modid: xfs-linux:slinx:161776a

2003/11/17 13:24:04-06:00 nathans
[XFS] Fix an infinite writepage loop under a combination of low free space, and racing write/unlink calls to the same file.

SGI Modid: xfs-linux:slinx:161773a

2003/11/17 13:00:32-06:00 nathans
[XFS] Fix sign on a pagebuf error variable, backport from 2.6 tree

SGI Modid: xfs-linux:slinx:161708a

2003/11/17 12:59:34-06:00 nathans
[XFS] Remove some spurious 2.4/2.6 differences in support code

SGI Modid: xfs-linux:slinx:161707a

2003/11/17 12:05:40-06:00 cattelan
Merge lips.thebarn.com:/export/hose/bkroot/linux-2.4
into lips.thebarn.com:/export/hose/bkroot/linux-2.4+justXFS

2003/11/15 11:05:29-06:00 cattelan
Merge lips.thebarn.com:/export/hose/bkroot/linux-2.4
into lips.thebarn.com:/export/hose/bkroot/linux-2.4+justXFS

2003/11/15 08:05:34-06:00 cattelan
Merge lips.thebarn.com:/export/hose/bkroot/linux-2.4
into lips.thebarn.com:/export/hose/bkroot/linux-2.4+justXFS

2003/11/14 10:05:54-06:00 cattelan
Merge lips.thebarn.com:/export/hose/bkroot/linux-2.4
into lips.thebarn.com:/export/hose/bkroot/linux-2.4+justXFS

2003/11/14 09:05:46-06:00 cattelan
Merge lips.thebarn.com:/export/hose/bkroot/linux-2.4
into lips.thebarn.com:/export/hose/bkroot/linux-2.4+justXFS

2003/11/13 07:05:50-06:00 cattelan
Merge lips.thebarn.com:/export/hose/bkroot/linux-2.4
into lips.thebarn.com:/export/hose/bkroot/linux-2.4+justXFS

2003/11/13 05:06:30-06:00 cattelan
Merge lips.thebarn.com:/export/hose/bkroot/linux-2.4
into lips.thebarn.com:/export/hose/bkroot/linux-2.4+justXFS

2003/11/11 12:05:50-06:00 cattelan
Merge lips.thebarn.com:/export/hose/bkroot/linux-2.4
into lips.thebarn.com:/export/hose/bkroot/linux-2.4+justXFS

2003/11/11 11:13:25-06:00 cattelan
Merge cattelan@xfs.org:/export/hose/bkroot/linux-2.4+justXFS
into naboo.americas.sgi.com:/go/space/BKpulls/linux-2.4+justXFS

2003/11/11 10:59:22-06:00 nathans
[XFS] Fix a deadlock while writing when low on free space.

SGI Modid: xfs-linux:slinx:161506a

2003/11/10 17:02:57-06:00 cattelan
Merge lips.thebarn.com:/export/hose/bkroot/linux-2.4
into lips.thebarn.com:/export/hose/bkroot/linux-2.4+justXFS

2003/11/10 05:02:52-06:00 cattelan
Merge lips.thebarn.com:/export/hose/bkroot/linux-2.4
into lips.thebarn.com:/export/hose/bkroot/linux-2.4+justXFS

2003/11/06 19:02:50-06:00 cattelan
Merge lips.thebarn.com:/export/hose/bkroot/linux-2.4
into lips.thebarn.com:/export/hose/bkroot/linux-2.4+justXFS

2003/11/06 11:02:54-06:00 cattelan
Merge lips.thebarn.com:/export/hose/bkroot/linux-2.4
into lips.thebarn.com:/export/hose/bkroot/linux-2.4+justXFS

2003/11/05 15:19:24-06:00 cattelan
Merge cattelan@xfs.org:/export/hose/bkroot/linux-2.4+justXFS/
into naboo.americas.sgi.com:/go/space/BKpulls/linux-2.4+justXFS

2003/11/05 15:18:48-06:00 roehrich
[XFS] dm_path_to_handle returns errnos with sign flipped.

SGI Modid: xfs-linux:slinx:161149a

2003/11/05 15:17:28-06:00 nathans
[XFS] Fix a supplemental issue introduced by the last small blocksize locking fix; this would manifest itself as a second unlock_page call on an already unlocked page.

SGI Modid: xfs-linux:slinx:160901a

2003/11/05 15:16:27-06:00 sandeen
[XFS] Fix test for large sector_t when finding max file offset

SGI Modid: xfs-linux:slinx:160900a

2003/11/05 15:15:12-06:00 sandeen
[XFS] Add a stack trace to _xfs_force_shutdown.

SGI Modid: xfs-linux:slinx:160899a

2003/11/05 06:04:41-06:00 cattelan
Merge lips.thebarn.com:/export/hose/bkroot/linux-2.4
into lips.thebarn.com:/export/hose/bkroot/linux-2.4+justXFS

2003/11/04 07:02:49-06:00 cattelan
Merge lips.thebarn.com:/export/hose/bkroot/linux-2.4
into lips.thebarn.com:/export/hose/bkroot/linux-2.4+justXFS

2003/11/04 05:02:47-06:00 cattelan
Merge lips.thebarn.com:/export/hose/bkroot/linux-2.4
into lips.thebarn.com:/export/hose/bkroot/linux-2.4+justXFS

2003/11/03 11:03:36-06:00 cattelan
Merge lips.thebarn.com:/export/hose/bkroot/linux-2.4
into lips.thebarn.com:/export/hose/bkroot/linux-2.4+justXFS

2003/10/30 16:06:08-06:00 cattelan
Merge lips.thebarn.com:/export/hose/bkroot/linux-2.4
into lips.thebarn.com:/export/hose/bkroot/linux-2.4+justXFS

2003/10/30 10:05:58-06:00 cattelan
Merge lips.thebarn.com:/export/hose/bkroot/linux-2.4
into lips.thebarn.com:/export/hose/bkroot/linux-2.4+justXFS

2003/10/29 18:05:41-06:00 cattelan
Merge lips.thebarn.com:/export/hose/bkroot/linux-2.4
into lips.thebarn.com:/export/hose/bkroot/linux-2.4+justXFS

2003/10/29 14:25:16-06:00 cattelan
Merge cattelan@xfs.org:/export/hose/bkroot/linux-2.4+justXFS/
into naboo.americas.sgi.com:/go/space/BKpulls/linux-2.4+justXFS

2003/10/29 14:14:23-06:00 nathans
[XFS] Fix pagebuf page locking problems for blocksizes smaller than the pagesize.

SGI Modid: xfs-linux:slinx:160795a

2003/10/29 14:13:01-06:00 nathans
[XFS] Fix warnings when tracing enabled on 64 bit platforms

SGI Modid: xfs-linux:slinx:160622a

2003/10/29 12:57:18-06:00 nathans
[XFS] Dump the pagebuf locked field for debugging purposes

SGI Modid: xfs-linux:slinx:160616a

2003/10/29 12:56:33-06:00 roehrich
[XFS] Remove duplicate FILP_DELAY_FLAG macro

SGI Modid: xfs-linux:slinx:160503a

2003/10/29 12:55:47-06:00 nathans
[XFS] Dont build objects which are not linked into the kernel ever.

SGI Modid: xfs-linux:slinx:160314a

2003/10/29 12:55:03-06:00 nathans
[XFS] Fix compiler warning when building on 2.4.21 kernels.

2003/10/29 12:54:01-06:00 nathans
[XFS] Fix compile warning on 64 bit platforms.

SGI Modid: xfs-linux:slinx:160312a

2003/10/29 12:53:07-06:00 nathans
[XFS] Enable the tracing options in XFS Makefiles.

SGI Modid: xfs-linux:slinx:160246a

2003/10/29 12:52:08-06:00 nathans
[XFS] Fix build with tracing enabled, couple of portability macros, move externs into headers.

SGI Modid: xfs-linux:slinx:160245a

2003/10/29 12:51:05-06:00 nathans
[XFS] When tracing extended attribute calls, only access the buffer when it exists.

SGI Modid: xfs-linux:slinx:160244a

2003/10/29 12:50:15-06:00 nathans
[XFS] Fix exports for tracing symbol access in idbg code.

2003/10/29 12:49:11-06:00 nathans
[XFS] Enable tracing in the quota code if requested

SGI Modid: xfs-linux:slinx:160242a

2003/10/29 12:48:29-06:00 nathans
[XFS] Rename the vnode tracing macro to be consistent with the other trace code

2003/10/29 12:47:20-06:00 nathans
[XFS] Fix build fallout from reordering xfsidbg headers for tracing fixes.

SGI Modid: xfs-linux:slinx:160225a

2003/10/29 12:46:37-06:00 nathans
[XFS] Add back xfsidbg tracing code, remove ktrace<->debug dependency.

SGI Modid: xfs-linux:slinx:160219a

2003/10/29 12:45:55-06:00 nathans
[XFS] Fix log tracing code so it is independent of DEBUG like other traces.

SGI Modid: xfs-linux:slinx:160178a

2003/10/29 12:45:07-06:00 nathans
[XFS] Fix ktrace code - dont build unilaterally, and do earlier init for pagebuf use.

SGI Modid: xfs-linux:slinx:160172a

2003/10/29 12:44:15-06:00 nathans
[XFS] Add some IO path tracing, move inval_cached_pages to a better home to help.

SGI Modid: xfs-linux:slinx:160171a

2003/10/29 12:43:18-06:00 roehrich
[XFS] Implement dm_get_bulkall

SGI Modid: xfs-linux:slinx:159760a

2003/10/29 12:42:25-06:00 nathans
[XFS] Fix inode btree lookup code precision problem with large allocation groups

SGI Modid: xfs-linux:slinx:160092a

2003/10/29 12:41:35-06:00 nathans
[XFS] final round of code cleanup, now using 3-clause-bsd in these headers

SGI Modid: xfs-linux:slinx:159997a

2003/10/29 12:40:50-06:00 nathans
[XFS] Use an xfs_ino_t to hold the result of inode extraction from a handle, not a possibly 32-bit number

2003/10/29 12:39:41-06:00 overby
[XFS] xfs_dir2_node_addname_int had reminants of an old block placement
algorithm in it.  The old algorithm appeared to look for the first
place to put a new data block, and thus a new freespace block (this is
where the 'foundindex' variable came from).  However, new space in a
directory is always added at the lowest file offset as determined by
the extent list.  So this stuff is never used.

I completely ripped out the reminants of the old algorithm, and
(again) moved the freespace block add code inside the conditional
where a data block is added.

SGI Modid: xfs-linux:slinx:159751a

2003/10/29 12:37:50-06:00 nathans
[XFS] Fix compiler warning after change to xfs_ioctl interface.

SGI Modid: xfs-linux:slinx:159720a

2003/10/29 12:36:52-06:00 nathans
[XFS] Rename pagebuf debug option (ie. pagebuf tracing) into a generic XFS tracing option for the other XFS trace code to use too (once fixed).

SGI Modid: xfs-linux:slinx:159717a

2003/10/29 12:34:37-06:00 overby
[XFS] A problem was found with the debug code in xlog_state_do_callback.  At
the end of processing all log buffers that can be processed, there is
a (debug only) double-check to make sure that log buffers with
completed I/O don't get marooned when the function completes.  The
check only needs to go to the first buffer that will cause an I/O
completion, that has not completed.  The loop doesn't stop a WANT_SYNC
state buffer is found, but it should.

SGI Modid: xfs-linux:slinx:159683a

2003/10/29 07:05:44-06:00 cattelan
Merge lips.thebarn.com:/export/hose/bkroot/linux-2.4
into lips.thebarn.com:/export/hose/bkroot/linux-2.4+justXFS

2003/10/28 23:28:26-06:00 lord
[XFS] remove FINVIS from xfs, instead use a seperate file ops
vector for files which are opened for invisible I/O.

SGI Modid: xfs-linux:slinx:159680a

2003/10/28 23:21:52-06:00 nathans
[XFS] Fix up pointers in diagnostics, print using %p not %x for 64 bit platforms

SGI Modid: xfs-linux:slinx:159652a

2003/10/28 21:01:08-06:00 cattelan
Merge lips.thebarn.com:/export/hose/bkroot/linux-2.4
into lips.thebarn.com:/export/hose/bkroot/linux-2.4+justXFS

2003/10/07 20:34:13-05:00 lord
[XFS] cleanup uio use some more

SGI Modid: xfs-linux:slinx:159633a

2003/10/07 19:24:42-05:00 cattelan
[XFS] switch xfs to use linux imode flags internally

SGI Modid: xfs-linux:slinx:159631a

2003/10/06 16:16:49-05:00 lord
[XFS] Implement deletion of inode clusters in XFS.

SGI Modid: xfs-linux:slinx:159536a

2003/10/06 10:58:41-05:00 cattelan
Merge naboo.americas.sgi.com:/go/space/BKpulls/linux-2.4
into naboo.americas.sgi.com:/go/space/BKpulls/linux-2.4+justXFS

2003/10/06 10:57:44-05:00 lord
[XFS] fix up error unlock paths in xfs_write

2003/10/06 10:54:18-05:00 lord
[XFS] fix the previous change which compiled by fluke, the conditional
use of the i_alloc_sem was wrong. No actual change in the generated
code for 2.4.22, there will be for older kernels though.

SGI Modid: xfs-linux:slinx:159426a

2003/10/06 10:49:57-05:00 lord
[XFS] small cleanup

SGI Modid: xfs-linux:slinx:159477a

2003/10/06 10:49:07-05:00 cattelan
[XFS] Fix remount,ro path

SGI Modid: xfs-linux:slinx:159444a

2003/10/06 10:47:32-05:00 lord
[XFS] Code cleanup

SGI Modid: xfs-linux:slinx:159439a

2003/10/06 10:45:52-05:00 lord
[XFS] move unwritten extent conversion for O_DIRECT into the write
thread and out of the I/O completion threads. This scales
better.

2003/10/06 10:44:52-05:00 lord
[XFS] Rework how xfs and the linux generic I/O code interoperate
again to deal with deadlock issues between the i_sem and
i_alloc_sem and the xfs IO lock.

SGI Modid: xfs-linux:slinx:159239a

2003/10/06 10:43:32-05:00 lord
[XFS] When calculating the number of pages to probe for an unwritten extent,
use the size of the extent, not the page count of the pagebuf which is
initialized to zero.

2003/09/29 11:02:59-05:00 cattelan
Merge naboo.americas.sgi.com:/go/space/BKpulls/linux-2.4
into naboo.americas.sgi.com:/go/space/BKpulls/linux-2.4+justXFS

2003/09/26 15:03:58-05:00 nathans
[XFS] Clean up inode revalidation code slightly

SGI Modid: xfs-linux:slinx:159031a

2003/09/26 15:03:03-05:00 nathans
[XFS] Fix a broken interaction between a buffered read into an unwritten extent and a direct write

2003/09/24 17:20:02-05:00 roehrich
[XFS] Make dm_send_data_event use vp rather than bhv

SGI Modid: xfs-linux:slinx:158840a

2003/09/24 17:09:17-05:00 lord
[XFS] Close some holes in the metadata flush logic used during unmount,
make sure we have no pending I/O completion calls for metadata,
and that we only keep hold of metadata buffers for I/O completion
if we want to. Still not perfect, but better than it was.

SGI Modid: xfs-linux:slinx:158933a

2003/09/24 17:08:02-05:00 lord
[XFS] remove dead function xfs_trans_iput

SGI Modid: xfs-linux:slinx:158917a

2003/09/23 11:10:33-05:00 lord
[XFS] Switch pagebuf hashing to be based on the block_device address
rather than the dev_t. Should give better distribution.

SGI Modid: xfs-linux:slinx:158800a

2003/09/23 10:51:37-05:00 nathans
[XFS] Rename _inode_init_once to __inode_init_once to follow the kernel naming convention a bit more closely.

2003/09/22 15:27:42-05:00 lord
[XFS] remove an impossible code path from mkdir and link paths,
spotted by Al Viro.

SGI Modid: xfs-linux:slinx:155518a

2003/09/22 15:26:30-05:00 nathans
[XFS] Use xfs_dev_t size rather than dev_t size in xfs_attr_fork initialization

SGI Modid: xfs-linux:slinx:155551a

2003/09/22 15:25:37-05:00 nathans
[XFS] Use the same name for a function here as in the 2.5/2.6 tree

SGI Modid: xfs-linux:slinx:155552a

2003/09/22 15:22:02-05:00 nathans
[XFS] Remove xfs_attr_fetch.c - the one routine was a copy of another, so instead of fixing a bug in two places I merged the two routines.

SGI Modid: xfs-linux:slinx:157533a

2003/09/22 15:19:07-05:00 sandeen
[XFS] Allow full 32 bits in sector number when XFS_BIG_BLKNOS not set

SGI Modid: xfs-linux:slinx:158757a

2003/09/22 15:18:25-05:00 roehrich
[XFS] Change dm_send_destroy_event to use vnode ptrs rather than bhv ptrs

SGI Modid: xfs-linux:slinx:158752a

2003/09/22 15:17:43-05:00 nathans
[XFS] Change writepage code so that we mark a page uptodate if all of its buffers are uptodate, and we are not doing a partial page write

SGI Modid: xfs-linux:slinx:158720a

2003/09/22 15:16:44-05:00 lord
[XFS] Make xfs_ichgtime call mark_inode_dirty_sync instead of mark_inode_dirty
makes the just the inode look dirty, and not the inode and the data.

SGI Modid: xfs-linux:slinx:158670a

2003/09/22 15:16:00-05:00 sandeen
[XFS] Update sysctls - use ints, not ulongs, and show pagebuf
values in jiffies like everybody else

SGI Modid: xfs-linux:slinx:158665a

2003/09/22 15:15:09-05:00 sandeen
[XFS] Re-work pagebuf stats macros to help support per-cpu data

SGI Modid: xfs-linux:slinx:158653a

2003/09/22 15:14:26-05:00 nathans
[XFS] Make debug code _exactly_ how it used to be to save on tree merging.

SGI Modid: xfs-linux:slinx:158641a

2003/09/22 15:13:38-05:00 nathans
[XFS] Allow syncing the types header up more easily with userspace.

SGI Modid: xfs-linux:slinx:158640a

2003/09/22 15:12:52-05:00 nathans
[XFS] Accidentally switched some debug code off, reenable it.

SGI Modid: xfs-linux:slinx:158639a

2003/09/22 15:12:05-05:00 lord
[XFS] fix build for gcc 3.2

SGI Modid: xfs-linux:slinx:158511a

2003/09/22 15:10:27-05:00 nathans
[XFS] Some tweaks to the additional inode flags, suggested by Ethan

SGI Modid: xfs-linux:slinx:158493a

2003/09/22 15:07:05-05:00 nathans
[XFS] Implement several additional inode flags - immutable, append-only, etc; contributed by Ethan Benson.

SGI Modid: xfs-linux:slinx:158362a

2003/09/22 15:06:04-05:00 nathans
[XFS] Separate the big filesystems macro out into separate big inums and blknos macros; fix the check for too-large filesystems in the process.

SGI Modid: xfs-linux:slinx:158361a

2003/09/22 15:05:17-05:00 nathans
[XFS] Undo last mod, checked in against wrong bug number with wrong change message.

SGI Modid: xfs-linux:slinx:158358a

2003/09/22 15:04:17-05:00 nathans
[XFS] Separate the big filesystems macro out into separate big inums and blknos macros.  Also fix the check for too-large filesystems in the process.

SGI Modid: xfs-linux:slinx:158357a

2003/09/22 15:02:11-05:00 nathans
[XFS] DMAPI changes required by direct IO/fcntl setfl interaction races

SGI Modid: xfs-linux:slinx:157938a

2003/09/22 15:01:31-05:00 nathans
[XFS] Fix races between O_DIRECT and fcntl with F_SETFL flag on the XFS IO path

SGI Modid: xfs-linux:slinx:157936a

2003/09/22 15:00:30-05:00 nathans
[XFS] Add inode64 mount option; fix case where growfs can push 32 bit inodes into 64 bit space accidentally - both changes originally from IRIX

SGI Modid: xfs-linux:slinx:157935a

2003/09/22 14:59:44-05:00 sandeen
[XFS] remove doubly-included header files

SGI Modid: xfs-linux:slinx:157933a

2003/09/22 14:58:46-05:00 cattelan
[XFS] IRIX sets KM_SLEEP to 0 but the support routines sets KM_SLEEP to 1.
So somebodys shortcut on irix is incorrect on linux and results in the sleep
behaviour not being set.

SGI Modid: xfs-linux:slinx:157773a

2003/09/22 14:58:04-05:00 cattelan
[XFS] Fix from Christoph

gcc 3.3 complains about this and indeed it can only trigger if
someone magically enlarges __uint8_t :)

SGI Modid: xfs-linux:slinx:157731a

2003/09/22 14:57:12-05:00 cattelan
[XFS] Since we now have embeding trees and XFS has to support LBS which
typically 1 version back from the XFS TOT tree add support
for 2.4.22 with and #if KERNEL_VERSION

SGI Modid: xfs-linux:slinx:157579a

2003/09/22 14:56:02-05:00 nathans
[XFS] Automatically set logbsize for larger stripe units

SGI Modid: xfs-linux:slinx:157534a

2003/09/22 14:53:28-05:00 nathans
[XFS] Alternate, cleaner fix for the ENOSPC/ACL lookup problem

SGI Modid: xfs-linux:slinx:157531a

2003/09/22 14:52:27-05:00 roehrich
[XFS] Change dm_send_mount_event to use vnode ptrs rather than bhv ptrs

SGI Modid: xfs-linux:slinx:157485a

2003/09/22 14:51:43-05:00 roehrich
[XFS] Change dm_send_namesp_event to take vnode ptrs rather than bhv ptrs.

SGI Modid: xfs-linux:slinx:157475a

2003/09/22 14:50:08-05:00 lord
[XFS] fix up xfs_lowbit's use of ffs

SGI Modid: xfs-linux:slinx:156655a

2003/09/22 14:49:19-05:00 sandeen
[XFS] Re-work xfs stats macros to support per-cpu data

SGI Modid: xfs-linux:slinx:156453a

2003/09/22 14:48:14-05:00 roehrich
[XFS] fix some ia64 warnings in dmapi_xfs.c

SGI Modid: xfs-linux:slinx:156432a

2003/09/22 14:47:16-05:00 wessmith
[XFS] Work around gcc 2.96 bug in _lsn_cmp.

SGI Modid: xfs-linux:slinx:156280a

2003/09/22 14:46:05-05:00 nathans
[XFS] Fix a case where we could issue an unwritten extent buffer for IO without it being locked - an instant BUG trigger in the block layer

2003/09/22 14:45:09-05:00 nathans
[XFS] Tweak last dabuf fix, suggested by Steve, no longer uses bitfields but uchars instead

SGI Modid: xfs-linux:slinx:156269a

2003/09/22 14:44:04-05:00 tes
[XFS] pv=892598; rv=nathans@sgi.com;
Change xlog_verify_iclog() to use idx as zero based instead
of 1 based index into array.
Nathan tried this change out on some benchmarks and it seems
to help - stop the assert from happening.
Nathan will do the merge of this mod.

SGI Modid: xfs-linux:slinx:156160a

2003/09/22 14:43:10-05:00 nathans
[XFS] Fix a harmless typo - we were using a pagebuf flag not a bmap flag here; fortunately they have the same value (2).

2003/09/22 14:42:17-05:00 cattelan
[XFS] Clean up fsid_t abuses in dmapi

SGI Modid: xfs-linux:slinx:155999a

2003/09/22 14:41:29-05:00 lord
[XFS] do not put 0x in front of a decimal number, its confusing

SGI Modid: xfs-linux:slinx:155961a

2003/09/22 14:40:46-05:00 nathans
[XFS] Use the rounded down size value for all growfs calculations, else the last AG can be updated incorrectly

SGI Modid: xfs-linux:slinx:155936a

2003/09/22 14:40:00-05:00 cattelan
[XFS] Fix one more fsid_t type.

2003/09/22 14:39:05-05:00 nathans
[XFS] Fix a race condition in async pagebuf IO completion, by moving blk queue manipulation down into pagebuf.  Fix some busted comments in page_buf.h, use a more descriptive name for __pagebuf_iorequest.

SGI Modid: xfs-linux:slinx:155788a

2003/09/22 14:38:05-05:00 nathans
[XFS] Fix a compiler warning, sync_fs returns a value

2003/09/22 14:37:05-05:00 cattelan
[XFS] Rework pagebuf_delwri_flush to be list safe

SGI Modid: xfs-linux:slinx:155660a

2003/09/22 14:36:09-05:00 cattelan
[XFS] Fix some inconsistent types

SGI Modid: xfs-linux:slinx:155637a

2003/09/22 14:35:09-05:00 nathans
[XFS] Fix up the default ACL inherit case, in the presence of failure during applying the default ACL (eg. from ENOSPC).

SGI Modid: xfs-linux:slinx:155553a

2003/09/22 14:12:14-05:00 cattelan
Merge

2003/08/07 18:10:18-05:00 cattelan
Import changeset

BKrev: 3fd458catoZoCW3mFe00vC17PifSHA

Members: 
	ChangeSet:1.4315->1.4316 
	BitKeeper/etc/gone:1.1->1.2 
	BitKeeper/etc/gone:INITIAL->1.1 
	fs/xfs/Makefile:1.1->1.2 
	fs/xfs/Makefile:INITIAL->1.1 
	fs/xfs/xfs.h:1.1->1.2 
	fs/xfs/xfs.h:INITIAL->1.1 
	fs/xfs/xfs_acl.c:1.1->1.2 
	fs/xfs/xfs_acl.c:INITIAL->1.1 
	fs/xfs/xfs_acl.h:1.1->1.2 
	fs/xfs/xfs_acl.h:INITIAL->1.1 
	fs/xfs/xfs_ag.h:1.1->1.2 
	fs/xfs/xfs_ag.h:INITIAL->1.1 
	fs/xfs/xfs_alloc.c:1.1->1.2 
	fs/xfs/xfs_alloc.c:INITIAL->1.1 
	fs/xfs/xfs_alloc.h:1.1->1.2 
	fs/xfs/xfs_alloc.h:INITIAL->1.1 
	fs/xfs/xfs_alloc_btree.c:1.1->1.2 
	fs/xfs/xfs_alloc_btree.c:INITIAL->1.1 
	fs/xfs/xfs_alloc_btree.h:1.1->1.2 
	fs/xfs/xfs_alloc_btree.h:INITIAL->1.1 
	fs/xfs/xfs_arch.h:1.1->1.2 
	fs/xfs/xfs_arch.h:INITIAL->1.1 
	fs/xfs/xfs_attr.c:1.1->1.2 
	fs/xfs/xfs_attr.c:INITIAL->1.1 
	fs/xfs/xfs_attr.h:1.1->1.2 
	fs/xfs/xfs_attr.h:INITIAL->1.1 
	fs/xfs/xfs_attr_leaf.c:1.1->1.2 
	fs/xfs/xfs_attr_leaf.c:INITIAL->1.1 
	fs/xfs/xfs_attr_leaf.h:1.1->1.2 
	fs/xfs/xfs_attr_leaf.h:INITIAL->1.1 
	fs/xfs/xfs_attr_sf.h:1.1->1.2 
	fs/xfs/xfs_attr_sf.h:INITIAL->1.1 
	fs/xfs/xfs_bit.c:1.1->1.2 
	fs/xfs/xfs_bit.c:INITIAL->1.1 
	fs/xfs/xfs_bit.h:1.1->1.2 
	fs/xfs/xfs_bit.h:INITIAL->1.1 
	fs/xfs/xfs_bmap.c:1.1->1.2 
	fs/xfs/xfs_bmap.c:INITIAL->1.1 
	fs/xfs/xfs_bmap.h:1.1->1.2 
	fs/xfs/xfs_bmap.h:INITIAL->1.1 
	fs/xfs/xfs_bmap_btree.c:1.1->1.2 
	fs/xfs/xfs_bmap_btree.c:INITIAL->1.1 
	fs/xfs/xfs_bmap_btree.h:1.1->1.2 
	fs/xfs/xfs_bmap_btree.h:INITIAL->1.1 
	fs/xfs/xfs_btree.c:1.1->1.2 
	fs/xfs/xfs_btree.c:INITIAL->1.1 
	fs/xfs/xfs_btree.h:1.1->1.2 
	fs/xfs/xfs_btree.h:INITIAL->1.1 
	fs/xfs/xfs_buf.h:1.1->1.2 
	fs/xfs/xfs_buf.h:INITIAL->1.1 
	fs/xfs/xfs_buf_item.c:1.1->1.2 
	fs/xfs/xfs_buf_item.c:INITIAL->1.1 
	fs/xfs/xfs_buf_item.h:1.1->1.2 
	fs/xfs/xfs_buf_item.h:INITIAL->1.1 
	fs/xfs/xfs_cap.c:1.1->1.2 
	fs/xfs/xfs_cap.c:INITIAL->1.1 
	fs/xfs/xfs_cap.h:1.1->1.2 
	fs/xfs/xfs_cap.h:INITIAL->1.1 
	fs/xfs/xfs_clnt.h:1.1->1.2 
	fs/xfs/xfs_clnt.h:INITIAL->1.1 
	fs/xfs/xfs_da_btree.c:1.1->1.2 
	fs/xfs/xfs_da_btree.c:INITIAL->1.1 
	fs/xfs/xfs_da_btree.h:1.1->1.2 
	fs/xfs/xfs_da_btree.h:INITIAL->1.1 
	fs/xfs/xfs_dfrag.c:1.1->1.2 
	fs/xfs/xfs_dfrag.c:INITIAL->1.1 
	fs/xfs/xfs_dfrag.h:1.1->1.2 
	fs/xfs/xfs_dfrag.h:INITIAL->1.1 
	fs/xfs/xfs_dinode.h:1.1->1.2 
	fs/xfs/xfs_dinode.h:INITIAL->1.1 
	fs/xfs/xfs_dir.c:1.1->1.2 
	fs/xfs/xfs_dir.c:INITIAL->1.1 
	fs/xfs/xfs_dir.h:1.1->1.2 
	fs/xfs/xfs_dir.h:INITIAL->1.1 
	fs/xfs/xfs_dir2.c:1.1->1.2 
	fs/xfs/xfs_dir2.c:INITIAL->1.1 
	fs/xfs/xfs_dir2.h:1.1->1.2 
	fs/xfs/xfs_dir2.h:INITIAL->1.1 
	fs/xfs/xfs_dir2_block.c:1.1->1.2 
	fs/xfs/xfs_dir2_block.c:INITIAL->1.1 
	fs/xfs/xfs_dir2_block.h:1.1->1.2 
	fs/xfs/xfs_dir2_block.h:INITIAL->1.1 
	fs/xfs/xfs_dir2_data.c:1.1->1.2 
	fs/xfs/xfs_dir2_data.c:INITIAL->1.1 
	fs/xfs/xfs_dir2_data.h:1.1->1.2 
	fs/xfs/xfs_dir2_data.h:INITIAL->1.1 
	fs/xfs/xfs_dir2_leaf.c:1.1->1.2 
	fs/xfs/xfs_dir2_leaf.c:INITIAL->1.1 
	fs/xfs/xfs_dir2_leaf.h:1.1->1.2 
	fs/xfs/xfs_dir2_leaf.h:INITIAL->1.1 
	fs/xfs/xfs_dir2_node.c:1.1->1.2 
	fs/xfs/xfs_dir2_node.c:INITIAL->1.1 
	fs/xfs/xfs_dir2_node.h:1.1->1.2 
	fs/xfs/xfs_dir2_node.h:INITIAL->1.1 
	fs/xfs/xfs_dir2_sf.c:1.1->1.2 
	fs/xfs/xfs_dir2_sf.c:INITIAL->1.1 
	fs/xfs/xfs_dir2_sf.h:1.1->1.2 
	fs/xfs/xfs_dir2_sf.h:INITIAL->1.1 
	fs/xfs/xfs_dir2_trace.c:1.1->1.2 
	fs/xfs/xfs_dir2_trace.c:INITIAL->1.1 
	fs/xfs/xfs_dir2_trace.h:1.1->1.2 
	fs/xfs/xfs_dir2_trace.h:INITIAL->1.1 
	fs/xfs/xfs_dir_leaf.c:1.1->1.2 
	fs/xfs/xfs_dir_leaf.c:INITIAL->1.1 
	fs/xfs/xfs_dir_leaf.h:1.1->1.2 
	fs/xfs/xfs_dir_leaf.h:INITIAL->1.1 
	fs/xfs/xfs_dir_sf.h:1.1->1.2 
	fs/xfs/xfs_dir_sf.h:INITIAL->1.1 
	fs/xfs/xfs_dmapi.h:1.1->1.2 
	fs/xfs/xfs_dmapi.h:INITIAL->1.1 
	fs/xfs/xfs_dmops.c:1.1->1.2 
	fs/xfs/xfs_dmops.c:INITIAL->1.1 
	fs/xfs/xfs_error.c:1.1->1.2 
	fs/xfs/xfs_error.c:INITIAL->1.1 
	fs/xfs/xfs_error.h:1.1->1.2 
	fs/xfs/xfs_error.h:INITIAL->1.1 
	fs/xfs/xfs_extfree_item.c:1.1->1.2 
	fs/xfs/xfs_extfree_item.c:INITIAL->1.1 
	fs/xfs/xfs_extfree_item.h:1.1->1.2 
	fs/xfs/xfs_extfree_item.h:INITIAL->1.1 
	fs/xfs/xfs_fs.h:1.1->1.2 
	fs/xfs/xfs_fs.h:INITIAL->1.1 
	fs/xfs/xfs_fsops.c:1.1->1.2 
	fs/xfs/xfs_fsops.c:INITIAL->1.1 
	fs/xfs/xfs_fsops.h:1.1->1.2 
	fs/xfs/xfs_fsops.h:INITIAL->1.1 
	fs/xfs/xfs_ialloc.c:1.1->1.2 
	fs/xfs/xfs_ialloc.c:INITIAL->1.1 
	fs/xfs/xfs_ialloc.h:1.1->1.2 
	fs/xfs/xfs_ialloc.h:INITIAL->1.1 
	fs/xfs/xfs_ialloc_btree.c:1.1->1.2 
	fs/xfs/xfs_ialloc_btree.c:INITIAL->1.1 
	fs/xfs/xfs_ialloc_btree.h:1.1->1.2 
	fs/xfs/xfs_ialloc_btree.h:INITIAL->1.1 
	fs/xfs/xfs_iget.c:1.1->1.2 
	fs/xfs/xfs_iget.c:INITIAL->1.1 
	fs/xfs/xfs_imap.h:1.1->1.2 
	fs/xfs/xfs_imap.h:INITIAL->1.1 
	fs/xfs/xfs_inode.c:1.1->1.2 
	fs/xfs/xfs_inode.c:INITIAL->1.1 
	fs/xfs/xfs_inode.h:1.1->1.2 
	fs/xfs/xfs_inode.h:INITIAL->1.1 
	fs/xfs/xfs_inode_item.c:1.1->1.2 
	fs/xfs/xfs_inode_item.c:INITIAL->1.1 
	fs/xfs/xfs_inode_item.h:1.1->1.2 
	fs/xfs/xfs_inode_item.h:INITIAL->1.1 
	fs/xfs/xfs_inum.h:1.1->1.2 
	fs/xfs/xfs_inum.h:INITIAL->1.1 
	fs/xfs/xfs_iocore.c:1.1->1.2 
	fs/xfs/xfs_iocore.c:INITIAL->1.1 
	fs/xfs/xfs_iomap.h:1.1->1.2 
	fs/xfs/xfs_iomap.h:INITIAL->1.1 
	fs/xfs/xfs_itable.c:1.1->1.2 
	fs/xfs/xfs_itable.c:INITIAL->1.1 
	fs/xfs/xfs_itable.h:1.1->1.2 
	fs/xfs/xfs_itable.h:INITIAL->1.1 
	fs/xfs/xfs_log.c:1.1->1.2 
	fs/xfs/xfs_log.c:INITIAL->1.1 
	fs/xfs/xfs_log.h:1.1->1.2 
	fs/xfs/xfs_log.h:INITIAL->1.1 
	fs/xfs/xfs_log_priv.h:1.1->1.2 
	fs/xfs/xfs_log_priv.h:INITIAL->1.1 
	fs/xfs/xfs_log_recover.c:1.1->1.2 
	fs/xfs/xfs_log_recover.c:INITIAL->1.1 
	fs/xfs/xfs_log_recover.h:1.1->1.2 
	fs/xfs/xfs_log_recover.h:INITIAL->1.1 
	fs/xfs/xfs_mac.c:1.1->1.2 
	fs/xfs/xfs_mac.c:INITIAL->1.1 
	fs/xfs/xfs_mac.h:1.1->1.2 
	fs/xfs/xfs_mac.h:INITIAL->1.1 
	fs/xfs/xfs_macros.c:1.1->1.2 
	fs/xfs/xfs_macros.c:INITIAL->1.1 
	fs/xfs/xfs_macros.h:1.1->1.2 
	fs/xfs/xfs_macros.h:INITIAL->1.1 
	fs/xfs/xfs_mount.c:1.1->1.2 
	fs/xfs/xfs_mount.c:INITIAL->1.1 
	fs/xfs/xfs_mount.h:1.1->1.2 
	fs/xfs/xfs_mount.h:INITIAL->1.1 
	fs/xfs/xfs_qmops.c:1.1->1.2 
	fs/xfs/xfs_qmops.c:INITIAL->1.1 
	fs/xfs/xfs_quota.h:1.1->1.2 
	fs/xfs/xfs_quota.h:INITIAL->1.1 
	fs/xfs/xfs_refcache.c:1.1->1.2 
	fs/xfs/xfs_refcache.c:INITIAL->1.1 
	fs/xfs/xfs_refcache.h:1.1->1.2 
	fs/xfs/xfs_refcache.h:INITIAL->1.1 
	fs/xfs/xfs_rename.c:1.1->1.2 
	fs/xfs/xfs_rename.c:INITIAL->1.1 
	fs/xfs/xfs_rtalloc.c:1.1->1.2 
	fs/xfs/xfs_rtalloc.c:INITIAL->1.1 
	fs/xfs/xfs_rtalloc.h:1.1->1.2 
	fs/xfs/xfs_rtalloc.h:INITIAL->1.1 
	fs/xfs/xfs_rw.c:1.1->1.2 
	fs/xfs/xfs_rw.c:INITIAL->1.1 
	fs/xfs/xfs_rw.h:1.1->1.2 
	fs/xfs/xfs_rw.h:INITIAL->1.1 
	fs/xfs/xfs_sb.h:1.1->1.2 
	fs/xfs/xfs_sb.h:INITIAL->1.1 
	fs/xfs/xfs_trans.c:1.1->1.2 
	fs/xfs/xfs_trans.c:INITIAL->1.1 
	fs/xfs/xfs_trans.h:1.1->1.2 
	fs/xfs/xfs_trans.h:INITIAL->1.1 
	fs/xfs/xfs_trans_ail.c:1.1->1.2 
	fs/xfs/xfs_trans_ail.c:INITIAL->1.1 
	fs/xfs/xfs_trans_buf.c:1.1->1.2 
	fs/xfs/xfs_trans_buf.c:INITIAL->1.1 
	fs/xfs/xfs_trans_extfree.c:1.1->1.2 
	fs/xfs/xfs_trans_extfree.c:INITIAL->1.1 
	fs/xfs/xfs_trans_inode.c:1.1->1.2 
	fs/xfs/xfs_trans_inode.c:INITIAL->1.1 
	fs/xfs/xfs_trans_item.c:1.1->1.2 
	fs/xfs/xfs_trans_item.c:INITIAL->1.1 
	fs/xfs/xfs_trans_priv.h:1.1->1.2 
	fs/xfs/xfs_trans_priv.h:INITIAL->1.1 
	fs/xfs/xfs_trans_space.h:1.1->1.2 
	fs/xfs/xfs_trans_space.h:INITIAL->1.1 
	fs/xfs/xfs_types.h:1.1->1.2 
	fs/xfs/xfs_types.h:INITIAL->1.1 
	fs/xfs/xfs_utils.c:1.1->1.2 
	fs/xfs/xfs_utils.c:INITIAL->1.1 
	fs/xfs/xfs_utils.h:1.1->1.2 
	fs/xfs/xfs_utils.h:INITIAL->1.1 
	fs/xfs/xfs_vfsops.c:1.1->1.2 
	fs/xfs/xfs_vfsops.c:INITIAL->1.1 
	fs/xfs/xfs_vnodeops.c:1.1->1.2 
	fs/xfs/xfs_vnodeops.c:INITIAL->1.1 
	fs/xfs/xfsidbg.c:1.1->1.2 
	fs/xfs/xfsidbg.c:INITIAL->1.1 
	fs/xfs/linux/Makefile:1.1->1.2 
	fs/xfs/linux/Makefile:INITIAL->1.1 
	fs/xfs/linux/xfs_aops.c:1.1->1.2 
	fs/xfs/linux/xfs_aops.c:INITIAL->1.1 
	fs/xfs/linux/xfs_behavior.c:1.1->1.2 
	fs/xfs/linux/xfs_behavior.c:INITIAL->1.1 
	fs/xfs/linux/xfs_behavior.h:1.1->1.2 
	fs/xfs/linux/xfs_behavior.h:INITIAL->1.1 
	fs/xfs/linux/xfs_cred.h:1.1->1.2 
	fs/xfs/linux/xfs_cred.h:INITIAL->1.1 
	fs/xfs/linux/xfs_file.c:1.1->1.2 
	fs/xfs/linux/xfs_file.c:INITIAL->1.1 
	fs/xfs/linux/xfs_fs_subr.c:1.1->1.2 
	fs/xfs/linux/xfs_fs_subr.c:INITIAL->1.1 
	fs/xfs/linux/xfs_fs_subr.h:1.1->1.2 
	fs/xfs/linux/xfs_fs_subr.h:INITIAL->1.1 
	fs/xfs/linux/xfs_globals.c:1.1->1.2 
	fs/xfs/linux/xfs_globals.c:INITIAL->1.1 
	fs/xfs/linux/xfs_globals.h:1.1->1.2 
	fs/xfs/linux/xfs_globals.h:INITIAL->1.1 
	fs/xfs/linux/xfs_ioctl.c:1.1->1.2 
	fs/xfs/linux/xfs_ioctl.c:INITIAL->1.1 
	fs/xfs/linux/xfs_iomap.c:1.1->1.2 
	fs/xfs/linux/xfs_iomap.c:INITIAL->1.1 
	fs/xfs/linux/xfs_iops.c:1.1->1.2 
	fs/xfs/linux/xfs_iops.c:INITIAL->1.1 
	fs/xfs/linux/xfs_iops.h:1.1->1.2 
	fs/xfs/linux/xfs_iops.h:INITIAL->1.1 
	fs/xfs/linux/xfs_linux.h:1.1->1.2 
	fs/xfs/linux/xfs_linux.h:INITIAL->1.1 
	fs/xfs/linux/xfs_lrw.c:1.1->1.2 
	fs/xfs/linux/xfs_lrw.c:INITIAL->1.1 
	fs/xfs/linux/xfs_lrw.h:1.1->1.2 
	fs/xfs/linux/xfs_lrw.h:INITIAL->1.1 
	fs/xfs/linux/xfs_stats.c:1.1->1.2 
	fs/xfs/linux/xfs_stats.c:INITIAL->1.1 
	fs/xfs/linux/xfs_stats.h:1.1->1.2 
	fs/xfs/linux/xfs_stats.h:INITIAL->1.1 
	fs/xfs/linux/xfs_super.c:1.1->1.2 
	fs/xfs/linux/xfs_super.c:INITIAL->1.1 
	fs/xfs/linux/xfs_super.h:1.1->1.2 
	fs/xfs/linux/xfs_super.h:INITIAL->1.1 
	fs/xfs/linux/xfs_sysctl.c:1.1->1.2 
	fs/xfs/linux/xfs_sysctl.c:INITIAL->1.1 
	fs/xfs/linux/xfs_sysctl.h:1.1->1.2 
	fs/xfs/linux/xfs_sysctl.h:INITIAL->1.1 
	fs/xfs/linux/xfs_version.h:1.1->1.2 
	fs/xfs/linux/xfs_version.h:INITIAL->1.1 
	fs/xfs/linux/xfs_vfs.c:1.1->1.2 
	fs/xfs/linux/xfs_vfs.c:INITIAL->1.1 
	fs/xfs/linux/xfs_vfs.h:1.1->1.2 
	fs/xfs/linux/xfs_vfs.h:INITIAL->1.1 
	fs/xfs/linux/xfs_vnode.c:1.1->1.2 
	fs/xfs/linux/xfs_vnode.c:INITIAL->1.1 
	fs/xfs/linux/xfs_vnode.h:1.1->1.2 
	fs/xfs/linux/xfs_vnode.h:INITIAL->1.1 
	fs/xfs/pagebuf/Makefile:1.1->1.2 
	fs/xfs/pagebuf/Makefile:INITIAL->1.1 
	fs/xfs/pagebuf/page_buf.c:1.1->1.2 
	fs/xfs/pagebuf/page_buf.c:INITIAL->1.1 
	fs/xfs/pagebuf/page_buf.h:1.1->1.2 
	fs/xfs/pagebuf/page_buf.h:INITIAL->1.1 
	fs/xfs/quota/Makefile:1.1->1.2 
	fs/xfs/quota/Makefile:INITIAL->1.1 
	fs/xfs/quota/xfs_dquot.c:1.1->1.2 
	fs/xfs/quota/xfs_dquot.c:INITIAL->1.1 
	fs/xfs/quota/xfs_dquot.h:1.1->1.2 
	fs/xfs/quota/xfs_dquot.h:INITIAL->1.1 
	fs/xfs/quota/xfs_dquot_item.c:1.1->1.2 
	fs/xfs/quota/xfs_dquot_item.c:INITIAL->1.1 
	fs/xfs/quota/xfs_dquot_item.h:1.1->1.2 
	fs/xfs/quota/xfs_dquot_item.h:INITIAL->1.1 
	fs/xfs/quota/xfs_qm.c:1.1->1.2 
	fs/xfs/quota/xfs_qm.c:INITIAL->1.1 
	fs/xfs/quota/xfs_qm.h:1.1->1.2 
	fs/xfs/quota/xfs_qm.h:INITIAL->1.1 
	fs/xfs/quota/xfs_qm_bhv.c:1.1->1.2 
	fs/xfs/quota/xfs_qm_bhv.c:INITIAL->1.1 
	fs/xfs/quota/xfs_qm_stats.c:1.1->1.2 
	fs/xfs/quota/xfs_qm_stats.c:INITIAL->1.1 
	fs/xfs/quota/xfs_qm_stats.h:1.1->1.2 
	fs/xfs/quota/xfs_qm_stats.h:INITIAL->1.1 
	fs/xfs/quota/xfs_qm_syscalls.c:1.1->1.2 
	fs/xfs/quota/xfs_qm_syscalls.c:INITIAL->1.1 
	fs/xfs/quota/xfs_quota_priv.h:1.1->1.2 
	fs/xfs/quota/xfs_quota_priv.h:INITIAL->1.1 
	fs/xfs/quota/xfs_trans_dquot.c:1.1->1.2 
	fs/xfs/quota/xfs_trans_dquot.c:INITIAL->1.1 
	fs/xfs/support/Makefile:1.1->1.2 
	fs/xfs/support/Makefile:INITIAL->1.1 
	fs/xfs/support/debug.c:1.1->1.2 
	fs/xfs/support/debug.c:INITIAL->1.1 
	fs/xfs/support/debug.h:1.1->1.2 
	fs/xfs/support/debug.h:INITIAL->1.1 
	fs/xfs/support/kmem.c:1.1->1.2 
	fs/xfs/support/kmem.c:INITIAL->1.1 
	fs/xfs/support/kmem.h:1.1->1.2 
	fs/xfs/support/kmem.h:INITIAL->1.1 
	fs/xfs/support/ktrace.c:1.1->1.2 
	fs/xfs/support/ktrace.c:INITIAL->1.1 
	fs/xfs/support/ktrace.h:1.1->1.2 
	fs/xfs/support/ktrace.h:INITIAL->1.1 
	fs/xfs/support/move.c:1.1->1.2 
	fs/xfs/support/move.c:INITIAL->1.1 
	fs/xfs/support/move.h:1.1->1.2 
	fs/xfs/support/move.h:INITIAL->1.1 
	fs/xfs/support/mrlock.c:1.1->1.2 
	fs/xfs/support/mrlock.c:INITIAL->1.1 
	fs/xfs/support/mrlock.h:1.1->1.2 
	fs/xfs/support/mrlock.h:INITIAL->1.1 
	fs/xfs/support/mutex.h:1.1->1.2 
	fs/xfs/support/mutex.h:INITIAL->1.1 
	fs/xfs/support/qsort.c:1.1->1.2 
	fs/xfs/support/qsort.c:INITIAL->1.1 
	fs/xfs/support/qsort.h:1.1->1.2 
	fs/xfs/support/qsort.h:INITIAL->1.1 
	fs/xfs/support/sema.h:1.1->1.2 
	fs/xfs/support/sema.h:INITIAL->1.1 
	fs/xfs/support/spin.h:1.1->1.2 
	fs/xfs/support/spin.h:INITIAL->1.1 
	fs/xfs/support/sv.h:1.1->1.2 
	fs/xfs/support/sv.h:INITIAL->1.1 
	fs/xfs/support/time.h:1.1->1.2 
	fs/xfs/support/time.h:INITIAL->1.1 
	fs/xfs/support/uuid.c:1.1->1.2 
	fs/xfs/support/uuid.c:INITIAL->1.1 
	fs/xfs/support/uuid.h:1.1->1.2 
	fs/xfs/support/uuid.h:INITIAL->1.1 
