Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261425AbULTGOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbULTGOt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 01:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbULTGOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 01:14:49 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:3509 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261425AbULTGOr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 01:14:47 -0500
Cc: openib-general@openib.org, akpm@osdl.org, torvalds@osdl.org
In-Reply-To: 
X-Mailer: Roland's Patchbomber
Date: Sun, 19 Dec 2004 22:14:43 -0800
Message-Id: <200412192214.KlDxQ7icOmxHYIf0@topspin.com>
Mime-Version: 1.0
To: linux-kernel@vger.kernel.org
From: Roland Dreier <roland@topspin.com>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH][v4][0/24] Second InfiniBand merge candidate patch set
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 20 Dec 2004 06:14:46.0520 (UTC) FILETIME=[34302780:01C4E65B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following series of patches is the latest version of the OpenIB
InfiniBand drivers.  We believe that this version is suitable for
merging when 2.6.11 opens (or into -mm immediately), although of
course we are willing to go through as many more iterations as
required to fix any remaining issues.

The previous posting last week did not generate many comments.  We
have fixed all the minor glitches identified, and updated the
copyright/license comments in the source files so that no external
files or URLs other than the main COPYING file are referenced (the
license remains unchanged as dual GPL/BSD).

In addition a fair bit of testing has been done and several bugs have
been fixed over the past week.  The IP-over-InfiniBand driver now
appears to work well on a broad range of hardware.

Merging these patches should be low-risk: the only non-documentation
changes outside of the new drivers/infiniband tree are a small set of
networking patches to handle devices of type AF_INFINIBAND where
appropriate.  These patches have been posted to netdev@oss.sgi.com
multiple times.

Linus/Andrew - is there any further that you want to see done, or do
these patches look acceptable to you?

Thanks,
  Roland Dreier
  OpenIB Alliance
  www.openib.org

