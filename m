Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130794AbRAFRfT>; Sat, 6 Jan 2001 12:35:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131047AbRAFRfB>; Sat, 6 Jan 2001 12:35:01 -0500
Received: from nnj-dialup-60-193.nni.com ([216.107.60.193]:4288 "EHLO
	nnj-dialup-60-193.nni.com") by vger.kernel.org with ESMTP
	id <S130794AbRAFRet>; Sat, 6 Jan 2001 12:34:49 -0500
Date: Sat, 6 Jan 2001 12:33:35 -0500 (EST)
From: TenThumbs <tenthumbs@cybernex.net>
Reply-To: TenThumbs <tenthumbs@cybernex.net>
To: linux-kernel@vger.kernel.org
Subject: 2.2.19pre6 change in /proc behavior
Message-ID: <Pine.LNX.4.21.0101061230450.239-100000@perfect.master>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Let's say a normal user has started a process with pid =
12345. /proc/12345 owner and group is the same as the user but
/proc/12345/* are all owned by root so the normal user can't read most
of the entries there. In 2.2.18 everything is owned by the user.

Is this supposed to be happening?

Thanks.

-- 
Sun
    2001-01-06 17:30:47.031 UTC (JD 2451916.229711)
    X  =  -0.004587559, Y  =  -0.004598857, Z  =  -0.001825999
    X' =   0.000008151, Y' =  -0.000003497, Z' =  -0.000001714

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
