Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268443AbRGXUQu>; Tue, 24 Jul 2001 16:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268445AbRGXUQk>; Tue, 24 Jul 2001 16:16:40 -0400
Received: from utopia.booyaka.com ([206.156.231.220]:39098 "HELO
	utopia.booyaka.com") by vger.kernel.org with SMTP
	id <S268443AbRGXUQ2>; Tue, 24 Jul 2001 16:16:28 -0400
Date: Tue, 24 Jul 2001 15:16:27 -0500
From: Ryan Dooley <ryan@utopia.booyaka.com>
To: linux-kernel@vger.kernel.org
Subject: soft read-only fs
Message-ID: <20010724151627.A12709@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi,

I was trying to come up with a project to do and I was wondering if anybody
had done work on a filesystem to support soft read only mounts.  This is
something I had seen on our F5 Big-IP boxes.  They are based on BSD/OS for
those who are intrested.

The soft read-only functionality checks to see if files are open for writing. 
If there are none, the file system gets downgraded to read-only.  When a file
opens up for writing, the file system is promoted to read-write.

It's probably not a necessity with the more journaling filesystems that get
working with Linux.  I just wanted to make sure I wasn't about to reinvent
the wheel (or fs if you like :-)

Cheers,
	Ryan

