Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288086AbSBSTzH>; Tue, 19 Feb 2002 14:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288960AbSBSTy5>; Tue, 19 Feb 2002 14:54:57 -0500
Received: from p3E9BFD8B.dip.t-dialin.net ([62.155.253.139]:46596 "EHLO
	srv.sistina.com") by vger.kernel.org with ESMTP id <S288086AbSBSTyq>;
	Tue, 19 Feb 2002 14:54:46 -0500
Date: Tue, 19 Feb 2002 20:51:06 +0100
From: "Heinz J . Mauelshagen" <mauelshagen@sistina.com>
To: linux-kernel@vger.kernel.org
Subject: *** ANNOUNCEMENT *** LVM 1.0.3 available at www.sistina.com
Message-ID: <20020219205106.A3759@sistina.com>
Reply-To: mauelshagen@sistina.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


*** ANNOUNCEMENT *** LVM 1.0.3 available at www.sistina.com

Hi all,

LVM 1.0.3 supports both version 1 and 2 of the metadata.

There's *no* need to run any metadata update tools.

A tarball is available now at

   <http://www.sistina.com/>

for download (Follow the "LVM 1.0" link).


Changes to LVM 1.0.2 include:

o vgcfgrestore supports restores to different sized physical volumes;
  useful in cases where a replacement disk is a little bit to large or
  for test purposes; option enhancements; physical volume UUID restore fix

o vgchange removes failed snapshots and activates the volume group rather
  than failing on it. Optionally forces device number changes in cases
  where it finds clashes so that the volume group can be activated

o vgexport exports volume groups not showing up in /etc/lvmtab*

o vgscan can drop all snapshots or those in a particular volume group now

o "pvmove -i" ignores read errors while moving and supports moves in
  inactive volume groups

o > 1 TB fixes for physical and logical volumes (2 TB limitation
  on 2.4 persists)

o more...


See the CHANGELOG file contained in the tarball for further information.

Feed back LVM related information to <linux-lvm@sistina.com>.

Thanks a lot for your support of LVM.

