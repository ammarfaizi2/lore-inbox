Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315458AbSFZAqa>; Tue, 25 Jun 2002 20:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316163AbSFZAq3>; Tue, 25 Jun 2002 20:46:29 -0400
Received: from rrcs-sw-24-153-135-82.biz.rr.com ([24.153.135.82]:18587 "HELO
	UberGeek") by vger.kernel.org with SMTP id <S315458AbSFZAq3>;
	Tue, 25 Jun 2002 20:46:29 -0400
Subject: max_scsi_luns and 2.4.19-pre10.
From: Austin Gonyou <austin@digitalroadkill.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 25 Jun 2002 19:46:25 -0500
Message-Id: <1025052385.19462.5.camel@UberGeek>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This originally was asking for help regarding QLA2200's, but I've since
discovered it's a kernel param problem that I'm not sure how to solve.

Using a default RH kernel (from SGI XFS installer) and passing
max_scsi_luns=128 in grub, and for scsi_mod, it seems to work. 

But when I compile my own kernels, none of that stuff is modular, it's
all built in. I though that passing max_scsi_luns at boot time would
make the scsi subsystem just work with > 8 luns, but so far that doesn't
appear to be the case. 


Can someone please tell me where I've gone wrong? I'm so deep into this,
I can't tell which way is up. 

TIA
-- 
Austin Gonyou <austin@digitalroadkill.net>
