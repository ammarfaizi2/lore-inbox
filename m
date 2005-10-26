Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932270AbVJZKee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbVJZKee (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 06:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932275AbVJZKee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 06:34:34 -0400
Received: from koto.vergenet.net ([210.128.90.7]:27558 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S932270AbVJZKed (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 06:34:33 -0400
Date: Wed, 26 Oct 2005 19:20:33 +0900
From: Horms <horms@debian.org>
To: "Aaron S. Hawley" <ashawley@gnu.uvm.edu>, 335733@bugs.debian.org
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Bug#335733: linux-source-2.6.12: README.gz doesn't mention bzip2 source tarball
Message-ID: <20051026102031.GQ28957@verge.net.au>
References: <E1EUSSL-0007i6-00@webteam-dvd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1EUSSL-0007i6-00@webteam-dvd>
X-Cluestick: seven
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2005 at 01:19:24PM -0400, Aaron S. Hawley wrote:
> Package: linux-source-2.6.12
> Version: 2.6.12-10
> Severity: minor
> 
> 
> Attached is a small patch that fixes this potential minor confusion.

Aaron, isn't it wonderful how people seize the opportunity
for confusion.

Andrew, I'm sending this your way, as I have no idea who to send it 
to. Its obviously correct, though trivial to say the least.

diff --git a/README b/README
index d1edcc7..4ee7dda 100644
--- a/README
+++ b/README
@@ -54,6 +54,10 @@ INSTALLING the kernel:
 
 		gzip -cd linux-2.6.XX.tar.gz | tar xvf -
 
+   or
+		bzip2 -dc linux-2.6.XX.tar.bz2 | tar xvf -
+
+
    Replace "XX" with the version number of the latest kernel.
 
    Do NOT use the /usr/src/linux area! This area has a (usually
