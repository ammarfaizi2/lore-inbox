Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751118AbVJDBW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbVJDBW5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 21:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbVJDBW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 21:22:57 -0400
Received: from smtp-out1.blueyonder.co.uk ([195.188.213.4]:62336 "EHLO
	smtp-out1.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S1751118AbVJDBW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 21:22:57 -0400
Subject: Missing header an own goal - now im cooked not raw, left sitting
	alone looking playing with my ttys
From: Jonathan Andrews <jon@jonshouse.co.uk>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 04 Oct 2005 02:23:04 +0100
Message-Id: <1128388984.5118.55.camel@jonspc>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Oct 2005 01:23:45.0665 (UTC) FILETIME=[43AD1F10:01C5C882]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://krtkg1.rug.ac.be/~colle/C/get_char_without_enter.html

Forgive my ignorance (on many levels), but please kind people - what is
the approved way to put a TTY into raw without using curses.

system("stty raw"); is not possible, as the code has to run embedded and
that distro lacks stty and some libs it likes.

I used to use code like the example above, but now structures like
TIOCGETP seem to be missing from the kernel headers?

So please kind people - what is the policy - show me the one true way,
the simplest way .......

Before anyone complains, it IS a kernel question - the kernel used to
have headers that worked with the above code - now it don't (unless im
wrong ..its possible).

The code is pre existing non curses application running on an embedded
machine with 2.4.27 kernel, im trying to build it on Fedora core 3
(2.6.12-1.1378_FC3)

Many thanks,
Jon



