Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263852AbTETQCm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 12:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263855AbTETQCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 12:02:41 -0400
Received: from ecology.tiem.utk.edu ([160.36.40.64]:38313 "HELO
	ecology.tiem.utk.edu") by vger.kernel.org with SMTP id S263852AbTETQCk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 12:02:40 -0400
To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
cc: peek@vger.kernel.org
Subject: Questions about LARGE, RAID storage under Linux
Date: Tue, 20 May 2003 12:15:39 -0400
From: "Michael S. Peek" <peek@tiem.utk.edu>
Message-Id: <S263852AbTETQCk/20030520160240Z+2889@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello all,

I am looking at using a hardware RAID device that appears to it's SCSI host as
a single large drive.  I am well aware that I can break this device down into
multiple LUNS, but if possible I need to keep it as one big drive.  I
understand from the Linux Info Sheet, last updated in 1998 according to it's
text, that Linux is able to handle partitions up to 4TB in size.

What I want to know is:

(a) Is 4TB still the maximum limitation on a single partition size?  If not,
what is the current maximum?

(b) Would this maximum partition size still apply when using the software RAID
tools to combine two or more of these devices together?

What I am looking for is the ability to mount and format an external SCSI
device that's 3.5TB in size.  (It's a Promise UltraTrak RM1500 w/ 15 x 250GB
drives).  I want to be able to upgrade the hard drives at a later date and
know that the Linux box to which it is attached will still be able to handle
them.  Ideally, I would like to purchase a second (or even a third) device
later down the road and use software RAID to concatenate them together.

Thanks for any help you can give,

Michael

