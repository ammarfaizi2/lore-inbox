Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129438AbRCACDt>; Wed, 28 Feb 2001 21:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129441AbRCACDj>; Wed, 28 Feb 2001 21:03:39 -0500
Received: from [63.122.164.11] ([63.122.164.11]:28933 "EHLO
	dbimail.digitalbiometrics.com") by vger.kernel.org with ESMTP
	id <S129438AbRCACD2>; Wed, 28 Feb 2001 21:03:28 -0500
Message-ID: <D0FA767FA2D5D31194990090279877DA57328F@dbimail.digitalbiometrics.com>
From: Neal Gieselman <Neal.Gieselman@Visionics.com>
To: linux-kernel@vger.kernel.org
Subject: ext3 fsck question
Date: Wed, 28 Feb 2001 20:03:21 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We are running ext3 1.20 on a 2.2 kernel for about a year now on
a flash disk.  No problems to speak of that we know of yet.
I just discovered that we do not have the fsck.ext3 nor any of
the other efs2progs utilities.  

I applied the libs and other utilites from e2fsprogs by hand.
I ran fsck.ext3 on my secondary partition and it ran fine.  The boot fsck
on / was complaining about something but I could not catch it.
I then went single user and ran fsck.ext3 on / while mounted.
Bad move.  It ran and reported many errors which I chose to repair.
It screwed the partition up to the point where it paniced on boot.
I could still get it into single user but I found that lots of files were
missing which happened to be located in lost+found (inittab, rc.local, etc).

Anyone else have luck with this combination?
Excuse the stupid question, but with ext3, do I really require the
fsck.ext3?  

