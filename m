Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263370AbTKFF4E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 00:56:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263373AbTKFF4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 00:56:04 -0500
Received: from web21505.mail.yahoo.com ([66.163.169.16]:57693 "HELO
	web21505.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263370AbTKFF4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 00:56:02 -0500
Message-ID: <20031106055601.75420.qmail@web21505.mail.yahoo.com>
Date: Wed, 5 Nov 2003 21:56:01 -0800 (PST)
From: Robert Gyazig <juliarobertz_fan@yahoo.com>
Subject: undo an mke2fs !!
To: tytso@mit.edu, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ted and others,

I created a new partition on my disk, and without
noticing the change in the hdaX of the partition i did
an  mke2fs /dev/hdaX. :(

Unfortunately it was my /home partition and was an
ext3 partition earlier. Can anyone please advice on
how to
retrieve the old data.

I read that mke2fs nukes all the meta information, so
does that mean all inodes are destroyed and there is
no hope for me ?!?!?

i did a cat /dev/hdaX > /dev/hdaY, which was an empty
partition earlier so that I can play around a bit. I
tried couple of things with debugfs but coudn't go
much far.

thanks
john

__________________________________
Do you Yahoo!?
Protect your identity with Yahoo! Mail AddressGuard
http://antispam.yahoo.com/whatsnewfree
