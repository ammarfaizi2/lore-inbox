Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130312AbQKGCjJ>; Mon, 6 Nov 2000 21:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130012AbQKGCi7>; Mon, 6 Nov 2000 21:38:59 -0500
Received: from lina.inka.de ([212.227.16.17]:60682 "EHLO matrix.inka.de")
	by vger.kernel.org with ESMTP id <S130312AbQKGCiq>;
	Mon, 6 Nov 2000 21:38:46 -0500
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] document ECN in 2.4 Configure.help
Message-Id: <E13syeh-00018h-00@calista.inka.de>
Date: Tue, 07 Nov 2000 03:38:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.10.10011060113240.8248-100000@waste.org> you wrote:
> I'm still not sure why it's been decided not to do fallback or how this
> whole situation is any different from path MTU discovery.

Because this will add a Fallback (non ECN) packet to every denied target. I
think this is bad policy at least. It might violate the RFCs, too. Keep in
mind, we cannot recognice a rejection due to ECN.

Greetings
Bernd
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
