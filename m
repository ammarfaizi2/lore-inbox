Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312134AbSDNW3V>; Sun, 14 Apr 2002 18:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312476AbSDNW3U>; Sun, 14 Apr 2002 18:29:20 -0400
Received: from hera.cwi.nl ([192.16.191.8]:64136 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S312134AbSDNW3U>;
	Sun, 14 Apr 2002 18:29:20 -0400
From: Andries.Brouwer@cwi.nl
Date: Sun, 14 Apr 2002 22:29:16 GMT
Message-Id: <UTC200204142229.WAA577107.aeb@cwi.nl>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: 2.5.8 does not boot
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hm, I submitted two patches against 2.5.8pre3,
but I see the real 2.5.8 has appeared already.
That makes the first patch superfluous.
The second one is still needed.

Booting 2.5.8 yields a crash at ide-disk.c:360
	BUG_ON(drive->tcq->active_tag != -1);

Andries
