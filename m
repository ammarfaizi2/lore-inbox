Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262109AbUK3PIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbUK3PIi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 10:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbUK3PIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 10:08:38 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:40928 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S262109AbUK3PIW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 10:08:22 -0500
Date: Tue, 30 Nov 2004 16:08:17 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: s390 patches for -bk.
Message-ID: <20041130150817.GA4758@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
another update for s390. This is the last patch-set from me for this
year. I asked Heiko Carstens (heiko.carstens@de.ibm.com) to keep an
eye on Bitkeeper for the next few weeks. If anything breaks he'll post
patches to keep s390 working.

The patches:
1) s390 core fixes
2) common i/o layer bug fixes
3) dcss segment interface changes
4) dasd driver fixes
5) z/VM monitor stream change
6) qeth network driver fixes. This patch depends on the last s390
   networking patch (s390-network-driver-patch in 2.6.10-rc2-mm4)
   which is pending because of the discussion about whether to drop
   network packets on a link failure or not. Thomas said that the
   discussion will take some more time.

blue skies,
  Martin.

