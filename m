Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932240AbVKUJ2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbVKUJ2m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 04:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbVKUJ2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 04:28:42 -0500
Received: from web36409.mail.mud.yahoo.com ([209.191.85.144]:14436 "HELO
	web36409.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932240AbVKUJ2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 04:28:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=y9n3aLfPcscE+Zi5sh427J0JewylfroW5JvAyY2Fc9lUFiamfDE1ZnSUX3PnfH+/nKeLMCwyNRxs+whNI04ezUfDRhUAQlDEgZ3mlRp/aHV8/bugmcOg6BXnK9lGRoOzJgUWx07wDalMBxceEu5vko5c/BHRzy7kdWvMZe6n/Fg=  ;
Message-ID: <20051121092841.47907.qmail@web36409.mail.mud.yahoo.com>
Date: Mon, 21 Nov 2005 01:28:41 -0800 (PST)
From: Alfred Brons <alfredbrons@yahoo.com>
Subject: what is our answer to ZFS?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I just noticed in the news this link:

http://www.opensolaris.org/os/community/zfs/demos/basics

I wonder what would be our respond to this beaste?

btw, you could try it live by using Nexenta
GNU/Solaris LiveCD at
http://www.gnusolaris.org/gswiki/Download which is
Ubuntu-based OpenSolaris
distribution.

So what is ZFS?

ZFS is a new kind of filesystem that provides simple
administration, transactional semantics, end-to-end
data integrity, and immense scalability. ZFS is not an
incremental improvement to existing technology; it is
a fundamentally new approach to data management. We've
blown away 20 years of obsolete assumptions,
eliminated complexity at the source, and created a
storage system that's actually a pleasure to use.

ZFS presents a pooled storage model that completely
eliminates the concept of volumes and the associated
problems of partitions, provisioning, wasted bandwidth
and stranded storage. Thousands of filesystems can
draw from a common storage pool, each one consuming
only as much space as it actually needs.

All operations are copy-on-write transactions, so the
on-disk state is always valid. There is no need to
fsck(1M) a ZFS filesystem, ever. Every block is
checksummed to prevent silent data corruption, and the
data is self-healing in replicated (mirrored or RAID)
configurations.

ZFS provides unlimited constant-time snapshots and
clones. A snapshot is a read-only point-in-time copy
of a filesystem, while a clone is a writable copy of a
snapshot. Clones provide an extremely space-efficient
way to store many copies of mostly-shared data such as
workspaces, software installations, and diskless
clients.

ZFS administration is both simple and powerful. The
tools are designed from the ground up to eliminate all
the traditional headaches relating to managing
filesystems. Storage can be added, disks replaced, and
data scrubbed with straightforward commands.
Filesystems can be created instantaneously, snapshots
and clones taken, native backups made, and a
simplified property mechanism allows for setting of
quotas, reservations, compression, and more.

Alfred


		
__________________________________ 
Yahoo! FareChase: Search multiple travel sites in one click.
http://farechase.yahoo.com
