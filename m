Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261475AbVDJLtB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261475AbVDJLtB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 07:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261478AbVDJLtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 07:49:00 -0400
Received: from cmailg4.svr.pol.co.uk ([195.92.195.174]:65290 "EHLO
	cmailg4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id S261475AbVDJLs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 07:48:58 -0400
Message-Id: <200504101148.j3ABmpu04734@blake.inputplus.co.uk>
To: Christopher Li <lkml@chrisli.org>
cc: Linus Torvalds <torvalds@osdl.org>, Petr Baudis <pasky@ucw.cz>,
       "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: more git updates.. 
In-Reply-To: <20050410065307.GC13853@64m.dyndns.org> 
Date: Sun, 10 Apr 2005 12:48:51 +0100
From: Ralph Corderoy <ralph@inputplus.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Christopher Li wrote:
> On Sat, Apr 09, 2005 at 04:31:10PM -0700, Linus Torvalds wrote:
> > NOTE! This means that each "tree" file basically tracks just a
> > single directory. The old style of "every file in one tree file"
> > still works, but fsck-cache will warn about it. Happily, the git
> > archive itself doesn't have any subdirectories, so git itself is not
> > impacted by it.
> 
> That is really cool stuff. My way to read it, correct me if I am
> wrong, git is a user space version file system. "tree" <--> directory
> and "blob" <--> file.  "commit" to describe the version history.

See the Venti filesystem in Bell Labs's Plan 9 OS.  It too uses SHA-1.

    http://www.cs.bell-labs.com/sys/doc/venti/venti.pdf

    Abstract

    This paper describes a network storage system, called Venti,
    intended for archival data. In this system, a unique hash of a
    block's contents acts as the block identifier for read and write
    operations. This approach enforces a write-once policy, preventing
    accidental or malicious destruction of data. In addition, duplicate
    copies of a block can be coalesced, reducing the consumption of
    storage and simplifying the implementation of clients. Venti is a
    building block for constructing a variety of storage applications
    such as logical backup, physical backup, and snapshot file systems.

    We have built a prototype of the system and present some preliminary
    performance results. The system uses magnetic disks as the storage
    technology, resulting in an access time for archival data that is
    comparable to non-archival data. The feasibility of the write-once
    model for storage is demonstrated using data from over a decade's
    use of two Plan 9 file systems. 

Cheers,


Ralph.

