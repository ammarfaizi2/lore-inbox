Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263456AbTJWJ2A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 05:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263504AbTJWJ2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 05:28:00 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:17792 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263456AbTJWJ17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 05:27:59 -0400
Date: Thu, 23 Oct 2003 10:30:00 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200310230930.h9N9U0B4006046@81-2-122-30.bradfords.org.uk>
To: linux-kernel@vger.kernel.org
Subject: In-kernel Gopher server
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apparently my suggestion of a couple of weeks ago, for an in-kernel
gopher server to aid remote administration and configuration, wasn't
clear enough.

Having just read:

http://lwn.net/Articles/53019/

I get the impression that I was understood to be suggesting we
implement a generic in-kenrel gopher server, much like the kernel
webserver that was removed.

The point is that if you look after systems that are on-line 24-hours
a day, being able to have a look at data in /proc, or the .config of
the current kernel from a portable device would be quite useful, if
you suddenly start getting calls saying something like a webserver
isn\'t responding.

Implementing a web-based interface to such data is all very well until
you want to access it on a device the size of a wristwatch.

John.
