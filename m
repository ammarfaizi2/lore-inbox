Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264339AbTEaPXu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 11:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264346AbTEaPXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 11:23:50 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:52366 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S264339AbTEaPXt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 11:23:49 -0400
Subject: 2.4.18 /dev/random problem
From: Philippe Amelant <philippe.amelant@free.fr>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1054395393.20196.211.camel@smp-tux.free.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 31 May 2003 17:36:34 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I have a compaq server with a little problem.
cat /proc/sys/kernel/random/entropy_avail is always 0
so /dev/random block on all read.

I have read some discussion about /dev/random on this list.
and if I understand /dev/urandom rely on /dev/random for providing good
randomness and /dev/random rely on server activity for it's entropy.

But I don't understand why my disk activity doesn't refill the entropy
counter. If I try to mount floppy I get some entropy but even updating
locate db does not provide any entropy ? Should I activate something in
disk driver ?

Thank
-- 
Philippe Amelant <philippe.amelant@free.fr>

