Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbULAEcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbULAEcd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 23:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbULAEcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 23:32:33 -0500
Received: from quechua.inka.de ([193.197.184.2]:961 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261234AbULAEcc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 23:32:32 -0500
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Designing Another File System
Organization: Deban GNU/Linux Homesite
In-Reply-To: <cce9e37e04113018465091010f@mail.gmail.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.6-20040906 ("Baleshare") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1CZMAH-00053k-00@calista.eckenfels.6bone.ka-ip.net>
Date: Wed, 01 Dec 2004 05:32:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <cce9e37e04113018465091010f@mail.gmail.com> you wrote:
> systems.  The next release of Squashfs has considerably improved
> indexed directories which are O(1) for large directories.

Are you talking about time complexity based on a named lookup over the
number of files in a directory? (you might also want to look at the
complexity relative to the naming component length). What data structure
which is not wasting memory allows you those lookups? Even if you consider
hashing the name as a constant O(1) operation (which it isnt), you still can
get collisions.

Greetings
Bernd
