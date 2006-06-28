Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030493AbWF1J2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030493AbWF1J2f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 05:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030492AbWF1J2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 05:28:35 -0400
Received: from smtp4.poczta.interia.pl ([80.48.65.7]:25748 "EHLO
	smtp4.poczta.interia.pl") by vger.kernel.org with ESMTP
	id S1030487AbWF1J2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 05:28:34 -0400
Date: Wed, 28 Jun 2006 11:28:28 +0200
From: Marcin Glogowski <marcin.glogowski@interia.pl>
To: linux-kernel@vger.kernel.org
Subject: Question about buffer.c
Message-Id: <20060628112828.fbcc4a86.marcin.glogowski@interia.pl>
X-Mailer: Sylpheed version 2.1.9 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-EMID: d020aacc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have big problem with my filesystem based on squash (also ROM) compressed filesystem.
My problem is when I'm copying something from mounted loop device the buffer cache memory is growing up - I want to disable block caching because Linux is killing processess because of the buffered inodes.
Please tell me how to remove free list or touched buffer heads, or how to set the minimum cache size.
I tried to delete the bh with the brelse(bh); function but the /proc/memory shows that the buffer head wasn't released.
Is there an alternative for the getblk or ll_rw_block functions that don't use cache memory?
Best regards,
Marcin Glogowski

----------------------------------------------------------------------
PS. Fajny portal... >>> http://link.interia.pl/f196a

