Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261631AbUKGQDn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbUKGQDn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 11:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbUKGQDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 11:03:42 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:41010 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261631AbUKGQDe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 11:03:34 -0500
Date: Sun, 7 Nov 2004 17:03:35 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Florian Schirmer <jolt@tuxbox.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kbuild: make O=/build/dir broken
Message-ID: <20041107160335.GA14156@mars.ravnborg.org>
Mail-Followup-To: Florian Schirmer <jolt@tuxbox.org>,
	linux-kernel@vger.kernel.org
References: <200411071436.14046.jolt@tuxbox.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411071436.14046.jolt@tuxbox.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 07, 2004 at 02:36:08PM +0100, Florian Schirmer wrote:
> Hi,
> 
> i tried to build a kernel outside the src dir using <src dir>/make O=<build 
> dir>. This failed because of

Checked with -mm and latest from Linus with no problems. I have not tested
-rc1.

> 
> 1. scripts/kbuild/zconf.tab.c not available in the <src dir>
You need zconf.tab.c_shipped in src dir. Maybe it was not checked out?

> 2. usr/initramfs_list not available in the <build dir>
Old bug fixed some time ago.

Upgrade to latest 2.6.10 - you need to fetch daily snapshots.

	Sam
