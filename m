Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030193AbVI1HMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030193AbVI1HMQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 03:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030196AbVI1HMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 03:12:15 -0400
Received: from mailgate2.urz.uni-halle.de ([141.48.3.8]:15747 "EHLO
	mailgate2.uni-halle.de") by vger.kernel.org with ESMTP
	id S1030193AbVI1HMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 03:12:15 -0400
Date: Wed, 28 Sep 2005 09:11:55 +0200 (MEST)
From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH 0/7] HPET fixes and enhancements
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Bob Picco <bob.picco@hp.com>,
       Clemens Ladisch <clemens@ladisch.de>
Message-id: <20050928071155.23025.43523.balrog@turing>
Content-transfer-encoding: 7BIT
X-Scan-Signature: c29e4ce6268e1723fecad812e890699c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These patches remove a bunch of warts and quirks from the HPET drivers.


 arch/i386/kernel/time_hpet.c |   20 +++++++++++---------
 arch/x86_64/kernel/time.c    |   20 +++++++++++---------
 drivers/char/hpet.c          |   39 ++++++++++++++++++++++++---------------
 3 files changed, 46 insertions(+), 33 deletions(-)
