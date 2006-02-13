Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751662AbWBMJQp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751662AbWBMJQp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 04:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751659AbWBMJQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 04:16:45 -0500
Received: from zone4.gcu-squad.org ([213.91.10.50]:16108 "EHLO
	zone4.gcu-squad.org") by vger.kernel.org with ESMTP
	id S1751249AbWBMJQo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 04:16:44 -0500
Date: Mon, 13 Feb 2006 10:14:00 +0100 (CET)
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] quilt 0.43
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.14 (On: webmail.gcu.info)
Message-ID: <7Ks06MZm.1139822040.2403500.khali@localhost>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-2.1.2 (zone4.gcu-squad.org [127.0.0.1]); Mon, 13 Feb 2006 10:14:00 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

Quilt 0.43 has been released ten days ago (sorry for being slow). A
number of improvements may be of interest to kernel developers so I am
announcing it here on LKML.

Quilt 0.43 can be downloaded from here:
  http://savannah.nongnu.org/download/quilt/quilt-0.43.tar.gz

Bug fixes:
  Deleting the top patch works again,
  patch delimiter ("---") is no more eaten on refresh.

Compatibility:
  Huge efforts have been put into improving compatibility with many
  platforms. The git specific patch format extensions are better
  supported too.

New features:
  The mail command has been completely reworked,
  delete -r physically removes the deleted patch,
  delete --backup makes a backup copy of the deleted patch,
  annotate -P annotates a previous version of the file,
  import can preserve or merge comments when updating a patch,
  push detects reversed patches,
  diffstat options can be specified,
  patch delimiter ("---") is automatically inserted before diffstat.

Thanks,
--
Jean Delvare
