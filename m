Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313098AbSDOS3v>; Mon, 15 Apr 2002 14:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313132AbSDOS3u>; Mon, 15 Apr 2002 14:29:50 -0400
Received: from renoir.op.net ([207.29.195.4]:3854 "EHLO renoir.op.net")
	by vger.kernel.org with ESMTP id <S313098AbSDOS3t>;
	Mon, 15 Apr 2002 14:29:49 -0400
Date: Mon, 15 Apr 2002 14:32:35 +0000 (UTC)
From: robs@Op.Net
X-X-Sender: robs@max15g
To: linux-kernel@vger.kernel.org
Subject: 258 compile error and fix
Message-ID: <Pine.LNX.4.44.0204151425320.10427-100000@max15g>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have no idea what to say or who to send it to!

for 2.5.8, in init/main.c, function: start_kernel(void) -

"setup_per_cpu_areas();"

should NOT be called for single CPU systems, and kernel compiles (final
linkage) fails with it in.  A simple ifndef would fix it- I just
commented the line out and all is well. :)

Thank you!!

