Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314602AbSGAJuZ>; Mon, 1 Jul 2002 05:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314634AbSGAJuY>; Mon, 1 Jul 2002 05:50:24 -0400
Received: from mx1.elte.hu ([157.181.1.137]:50610 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S314602AbSGAJuY>;
	Mon, 1 Jul 2002 05:50:24 -0400
Date: Mon, 1 Jul 2002 11:49:39 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [patch] 2.4.19-pre10-ac2: O(1) scheduler merge, -B3. [SCHED_BATCH/SCHED_IDLE
 support]
Message-ID: <Pine.LNX.4.44.0207011133570.4167-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.44.0206161824211.9989@e2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the sched-2.4.19-pre10-ac2-B3 patch is a backport of my current 2.5
scheduler tree (2.5.24-D3), against 2.4.19-pre10-ac2. The patch includes
all the recent scheduler fixes that went into 2.5.24, plus the SCHED_BATCH
(SCHED_IDLE) feature.

The patch can be downloaded from:

	http://redhat.com/~mingo/O(1)-scheduler/sched-2.4.19-pre10-ac2-B3

the setbatch utility can be found at:

        http://redhat.com/~mingo/O(1)-scheduler/setbatch.c

the patch was tested on x86 UP and SMP boxes.

	Ingo

