Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317023AbSHYHQ6>; Sun, 25 Aug 2002 03:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317024AbSHYHQ6>; Sun, 25 Aug 2002 03:16:58 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:37579 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S317023AbSHYHQ5>;
	Sun, 25 Aug 2002 03:16:57 -0400
Message-ID: <1030260069.3d6885651f0cb@kolivas.net>
Date: Sun, 25 Aug 2002 17:21:09 +1000
From: conman@kolivas.net
To: linux-kernel@vger.kernel.org
Subject: Responsiveness performance patches (ck) fixed for 2.4.19
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I've fixed the patches I created that combine the following:

O(1) scheduler
preemptible
low latency
+/- 
rmap
aa vm

The scheduler merge was faulty and prevented preempt from working. It is now fixed.

Check it out here:
http://kernel.kolivas.net

Diffs separating out each addition will be available soon.

Cheers, enjoy!
Con Kolivas
