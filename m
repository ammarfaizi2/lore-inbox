Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265398AbUGDGYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265398AbUGDGYk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 02:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265399AbUGDGYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 02:24:40 -0400
Received: from mlf.linux.rulez.org ([192.188.244.13]:47632 "EHLO
	mlf.linux.rulez.org") by vger.kernel.org with ESMTP id S265398AbUGDGYj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 02:24:39 -0400
Date: Sun, 4 Jul 2004 08:24:32 +0200 (MEST)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: Re: [Linux-NTFS-Dev] [2.6.7 BK URL] NTFS 2.1.15 - Invaliade quotas
 when (re)mounting read-write.
In-Reply-To: <Pine.LNX.4.60.0407030826330.2415@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.21.0407040749150.31285-100000@mlf.linux.rulez.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 3 Jul 2004, Anton Altaparmakov wrote:
> On Sat, 3 Jul 2004, Szakacsits Szabolcs wrote:
>
> > Quotas aren't often used so read-write mount could have been just refused
> > until the more general things get implemented. No untested scenarios.
>
> There is no need for testing in this case [ ... explanation ... ] I am
> just doing what windows does itself...

Thanks for the explanation. Your idea looks ok but the implementation is
still untested. Bugs in the implementation can results side-effect like
trashed filesystems.

Please consider mentioning completely untested code in the future. People
should be aware of it.

	Szaka

