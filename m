Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129381AbRBYPiU>; Sun, 25 Feb 2001 10:38:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129394AbRBYPiK>; Sun, 25 Feb 2001 10:38:10 -0500
Received: from quechua.inka.de ([212.227.14.2]:25184 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S129381AbRBYPiA>;
	Sun, 25 Feb 2001 10:38:00 -0500
Date: Sun, 25 Feb 2001 16:35:34 +0100
To: linux-kernel@vger.kernel.org
Subject: partition table: chs question
Message-ID: <20010225163534.A12566@dungeon.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: aj@dungeon.inka.de (Andreas Jellinghaus)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi.

for partitions not in the first 8gb of a harddisk, what
should the c/h/s start and end value be ?

most fdisks seem to set start and end to 255/63/1023.
but partition magic creates partitions with start set to
0/1/1023 and end set to 255/63/1023, and detects a problem
if start is set to 255/63/1023.

so, how should a partition table look like ?

regards, andreas

