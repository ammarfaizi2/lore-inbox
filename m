Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbUCDBob (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 20:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbUCDBob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 20:44:31 -0500
Received: from granger.mail.mindspring.net ([207.69.200.148]:20278 "EHLO
	granger.mail.mindspring.net") by vger.kernel.org with ESMTP
	id S261357AbUCDBo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 20:44:28 -0500
From: Daniel Risacher <magnus@alum.mit.edu>
To: linux-kernel@vger.kernel.org
Subject: hard lockup w/ dvdrecord to ieee1394 drive
Reply-to: magnus@alum.mit.edu
Message-Id: <E1AyhuV-0002Gu-00@m5.risacher.org>
Date: Wed, 03 Mar 2004 20:44:27 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Using 2.6.3, if I try to use dvdrecord (dvdrtools v0.1.4) to record to
a firewire dvd burner, the entire system locks up. (To the extend that
alt-sysrq doesn't work)

I can sucessfully burn a dvd onto the same drive using growisofs,
which uses the cdrom driver (sr_mod) instead of the scsi generic
driver (sg) used by dvdrecord.

I tried updating to the latest ieee1394 code (as of this morning, from
linuxieee1394.org) which did not seem to help.

With 2.6.1, I had problems with sbp2 and hostap_plx, which are sharing
the same interrupt.  (I got it to work by updating to 2.6.3) This may
be related.

System is a dual athlon, if that makes any difference.

Can anyone else duplicate this problem?

-- 
     "The blues are multicolored."   -- Dave Lambert

Daniel Risacher                      magnus@alum.mit.edu
