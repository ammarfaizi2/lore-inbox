Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262551AbUKQXuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262551AbUKQXuP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 18:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262567AbUKQWDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 17:03:45 -0500
Received: from cantor.suse.de ([195.135.220.2]:4231 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262621AbUKQVSq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 16:18:46 -0500
Subject: [CFT] reject merging program
From: Chris Mason <mason@suse.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Wed, 17 Nov 2004 13:21:25 -0500
Message-Id: <1100715685.18452.17.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

I've been using Neil Brown's wiggle program for a while to merge
rejects, but it doesn't do quite what I need.  I've written a
(hopefully) less complex program with a shorter feature list.

rej just tries to find the right place in the file for the reject hunks,
and then pops up a merge tool (vimdiff, kdiff3, tkdiff etc) so you can
review the differences and pick the correct lines in the file.

It does try to do line based merging, and frequently gets it right.  Of
course, this doesn't relieve you from checking the results against the
reject, but should make merging easier.

The (very beta) first release is here:

ftp://ftp.suse.com/pub/people/mason/rej/rej-0.4.tar.gz

-chris




