Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317917AbSHDQAq>; Sun, 4 Aug 2002 12:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317944AbSHDQAq>; Sun, 4 Aug 2002 12:00:46 -0400
Received: from hera.cwi.nl ([192.16.191.8]:30926 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S317917AbSHDQAq>;
	Sun, 4 Aug 2002 12:00:46 -0400
From: Andries.Brouwer@cwi.nl
Date: Sun, 4 Aug 2002 18:03:44 +0200 (MEST)
Message-Id: <UTC200208041603.g74G3i404617.aeb@smtp.cwi.nl>
To: torvalds@transmeta.com, viro@math.psu.edu
Subject: [unPATCH]
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This afternoon I sent a small patch fixing some oopses in the
partition code. However, I now see that it is not difficult to
provoke many related oopses not fixed by the simple test for
non-NULL parent.
So, a more thorough accounting is needed of
driverfs_create_partitions() and driverfs_remove_partitions().

Andries
