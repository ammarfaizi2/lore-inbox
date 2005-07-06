Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261898AbVGFUTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbVGFUTu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 16:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262297AbVGFUNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:13:32 -0400
Received: from services106.cs.uwaterloo.ca ([129.97.152.164]:23535 "EHLO
	services106.cs.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S262333AbVGFTwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 15:52:34 -0400
X-Mailer: emacs 21.4.1 (via feedmail 8 I)
To: Jonathan Briggs <jbriggs@esoft.com>
Cc: "Alexander G. M. Smith" <agmsmith@rogers.com>, ross.biro@gmail.com,
       vonbrand@inf.utfsm.cl, mrmacman_g4@mac.com, Valdis.Kletnieks@vt.edu,
       ltd@cisco.com, gmaxwell@gmail.com, jgarzik@pobox.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
       zam@namesys.com, vs@thebsh.namesys.com, ndiller@namesys.com,
       ninja@slaphack.com, vitaly@thebsh.namesys.com
Subject: Re: reiser4 plugins
From: Hubert Chan <hubert@uhoreg.ca>
In-Reply-To: <1120675943.13341.10.camel@localhost> (Jonathan Briggs's
 message of "Wed, 06 Jul 2005 12:52:23 -0600")
References: <42CB1E12.2090005@namesys.com> <1740726161-BeMail@cr593174-a>
	<87hdf8zqca.fsf@evinrude.uhoreg.ca> <42CB7DE0.4050200@namesys.com>
	<1120675943.13341.10.camel@localhost>
X-Hashcash: 1:23:050706:jbriggs@esoft.com::KNnLqoUXaZIgzZjF:000000000000000000000000000000000000000000004OWg
X-Hashcash: 1:23:050706:agmsmith@rogers.com::aipTMQDSqqqjo/JN:000000000000000000000000000000000000000000ZFjW
X-Hashcash: 1:23:050706:ross.biro@gmail.com::+ymQmxRopyZR7wFF:000000000000000000000000000000000000000001MLSm
X-Hashcash: 1:23:050706:vonbrand@inf.utfsm.cl::1CV9jIyj2AC7RWa0:0000000000000000000000000000000000000000N7NW
X-Hashcash: 1:23:050706:mrmacman_g4@mac.com::DPZQgXO7bMgxwyFF:000000000000000000000000000000000000000000IIV0
X-Hashcash: 1:23:050706:valdis.kletnieks@vt.edu::MAupkvZv/kwkfL1q:00000000000000000000000000000000000000CClM
X-Hashcash: 1:23:050706:ltd@cisco.com::Kahg2On79Mb+KwHe:0000QZqH
X-Hashcash: 1:23:050706:gmaxwell@gmail.com::sq0RMphDWnxQnK8g:0000000000000000000000000000000000000000001aE+g
X-Hashcash: 1:23:050706:jgarzik@pobox.com::AMKt5W7Es9ug2dgj:00000000000000000000000000000000000000000000IFjD
X-Hashcash: 1:23:050706:hch@infradead.org::MmGM6s9AmuUg5nO8:00000000000000000000000000000000000000000001p8yD
X-Hashcash: 1:23:050706:akpm@osdl.org::+L4IGfEEkOTqR1GT:00000nii
X-Hashcash: 1:23:050706:linux-kernel@vger.kernel.org::3zjlCI0Ep3A4/a0N:000000000000000000000000000000002XC4x
X-Hashcash: 1:23:050706:reiserfs-list@namesys.com::H7Sw9hDvbeCqxLyL:000000000000000000000000000000000000UERa
X-Hashcash: 1:23:050706:zam@namesys.com::sKcKZh3TLHQBCXkX:00EK5Y
X-Hashcash: 1:23:050706:vs@thebsh.namesys.com::OAEZUmV3yutDRvc+:000000000000000000000000000000000000000004ye
X-Hashcash: 1:23:050706:ndiller@namesys.com::+l0bxo44tTZTMBZp:000000000000000000000000000000000000000000viqt
X-Hashcash: 1:23:050706:ninja@slaphack.com::/181bIFDvwfa0PI+:00000000000000000000000000000000000000000003y1v
X-Hashcash: 1:23:050706:vitaly@thebsh.namesys.com::uBii0fB4cgkt1fOw:000000000000000000000000000000000000AlzM
Date: Wed, 06 Jul 2005 15:51:58 -0400
Message-ID: <87mzozemqp.fsf@evinrude.uhoreg.ca>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (services106.cs.uwaterloo.ca [129.97.152.132]); Wed, 06 Jul 2005 15:52:15 -0400 (EDT)
X-Miltered: at rhadamanthus with ID 42CC36AC.004 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Jul 2005 12:52:23 -0600, Jonathan Briggs <jbriggs@esoft.com> said:

> On Tue, 2005-07-05 at 23:44 -0700, Hans Reiser wrote:
>> Hubert Chan wrote:
>>> And a question: is it feasible to store, for each
>>> inode, its parent(s), instead of just the hard link count?

>> Ooh, now that is an interesting old idea I haven't considered in 20
>> years.... makes fsck more robust too....

If you can store the parents, then finding cycles (relatively) quickly
is pretty easy: before you try to make A the parent of B, walk up the
parent pointers starting from A.  If you ever reach B, you have a cycle.
If not, you don't have a cycle.  (Hmmm.  Do I need a proof of
correctness for this?  It's just depth-first-search, which everybody
learned in their first algorithms course.)

Running time is (at most) just the sum of all (directed) path lengths
from A to the root.  Assuming people don't have too deep of a hierarchy,
or too much branching with hard links (i.e. nodes with too many
parents), which I think is a reasonable assumption, running time should
be fairly quick.

(People may have millions of files in a single directory, which is why
doing the DFS in the forward direction is a bad idea.  But people
probably don't have millions of hard links to the same file, or
hierarchies that are millions of levels deep.)

And it only happens when a hard link is created -- probably not a very
performance-dependent event (i.e. it's not the scheduling algorithm).  I
would imagine that some creative caching could be done to speed up the
situation where you try to make a whole batch of hard links.  (When you
walk up the parent pointers starting from A, cache the inode numbers
that you encounter.  If you then try to make A the parent of C, check if
C is one of the inode numbers in the cache.  If yes, we have a cycle; if
no, we don't have a cycle.)

Extra disk storage is just about one extra word for most nodes (that
only have one parent -- basically, one extra word per parent), if you
can pack the data efficiently.  (i.e. we don't want to waste a extra
whole block per node.)

Of course, since this requires extra storage on the part of the
filesystem, the (kernel) VFS change would have to be something where the
VFS asks the filesystem whether making A the parent of B will create a
cycle; it's not something the VFS can do transparently for everybody.
Filesystems that don't store this extra stuff just return "yes" if B is
a directory (thus disallowing the link), and "no" if B is a file, and we
get the same situation we have right now.

It would require a disk format change (sort of) in Reiser4, but (as Hans
mentioned) since we have plugins, shouldn't require a reformat (as I
understand it).  Just run a tool that builds the parent-pointer data;
until you run that tool, the filesystem can just disallow hard links.
After you run the tool, updating parent pointers is handled
automatically by the filesystem.

> Hey, sounds like the idea I proposed a couple months ago of storing
> the path names in each file, instead of in directories.  Only better,
> since each path component isn't text but a link instead.

> It still has the performance and locking problem of having to update
> every child file when moving a directory tree to a new parent.  On the
> other hand, maybe the benefit is worth the cost.

Every node should store the inode number(s) for its parent(s).  Not the
path name.  So you don't need to do any updates, since when you move a
tree, inode numbers don't change.

-- 
Hubert Chan <hubert@uhoreg.ca> - http://www.uhoreg.ca/
PGP/GnuPG key: 1024D/124B61FA
Fingerprint: 96C5 012F 5F74 A5F7 1FF7  5291 AF29 C719 124B 61FA
Key available at wwwkeys.pgp.net.   Encrypted e-mail preferred.

