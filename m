Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130247AbRCCDQQ>; Fri, 2 Mar 2001 22:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130241AbRCCDQG>; Fri, 2 Mar 2001 22:16:06 -0500
Received: from [211.100.92.132] ([211.100.92.132]:35590 "HELO lustre.us.mvd")
	by vger.kernel.org with SMTP id <S130239AbRCCDPx>;
	Fri, 2 Mar 2001 22:15:53 -0500
Date: Thu, 1 Mar 2001 14:38:32 -0800 (PST)
From: "Peter J. Braam" <braam@mountainviewdata.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [Announce] SnapFS Snapshot File System alpha release
Message-ID: <Pine.LNX.4.21.0103011437310.3231-100000@lustre.us.mvd>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SnapFS - Snapshot File System

Release:  alpha1
Requires: Linux 2.2.18 or later, Ext3 and EA. 
WWW site: http://www.mountainviewdata.com/technology/snapfs

Mountain View Data, Inc is announcing the first release of SnapFS.
SnapFS is a file system enhancement of Ext3 to bring fully featured
snapshots to Linux.  (You can use SnapFS with Ext2 but there is no
file system recovery tool.)

Making a snapshot of a file system allows the file and directory
layout at particular points in time to remain available read only.
This is done through careful management of multiple versions of
inodes.  SnapFS manages modifications to files and versions of files
at the block level to avoid space and CPU overhead.  Our white papers
describe the design in more detail.  Snapshots are made almost
instantaneously and typical usage is to make a snapshot before a
backup or major system administration.

SnapFS allows dynamic creation and removal of snapshots, and can roll
back a file system to a snapshot.  SnapFS comes with utilities that
can find incremental backup data extremely fast and SnapFS manages
disk block layout in such a way that LAN free backup programs can take
advantage of it.

SnapFS relies on Ext3 for recovery and on the Extended Attribute
package for storing versioning information.

The current release is usable, but has some known and likely some
unknown bugs.  Please backup your file systems before playing with
SnapFS and play at your own risk.

SnapFS is provided under the GPL.  Mountain View Data plans to release
additional configuration and management tools for SnapFS as commercial
products.

Acknowledgements: Stephen Tweedie has been instrumental in providing a
journal interface that supports filtering file systems like InterMezzo
and SnapFS.  Andreas Dilger wrote the first version of the Ext2 snap
api, and Andreas Gruenbacher has helped us with extended attribute
code.  Others are helping us with possible ports to 2.4, ReiserFS, XFS
and JFS.

SnapFS is being developed by Mountain View Data. It was designed and
partially written by Peter Braam.  The development is led by Harrison
Xing <harrison@mountainviewdata.com> and Eric Mei
<ericm@mountainviewdata.com> in the Beijing office of Mountain View
Data.  William Wei <william.wei@mountainviewdata.com> has helped with
initial QA.  Michael Gao and Thomas Corley have helped with the WWW
site and documentation.  Brian Murrell packaged SnapFS for a demo at
LinuxWorld.



-- 

