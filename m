Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136811AbRA1NB0>; Sun, 28 Jan 2001 08:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136952AbRA1NBR>; Sun, 28 Jan 2001 08:01:17 -0500
Received: from mout1.freenet.de ([194.97.50.132]:11719 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S136811AbRA1NBN>;
	Sun, 28 Jan 2001 08:01:13 -0500
From: Andreas Franck <afranck@gmx.de>
Date: Sun, 28 Jan 2001 14:01:20 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.0 loop device still hangs
MIME-Version: 1.0
Message-Id: <01012814012000.00354@dg1kfa.ampr.org>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

I've tested your patch quite as heavy as it gets: I created 5 files of each 
100 MB, set up 5 loop devices and made a RAID5 array out of them, putting 
ext2 on it and running a bonnie loop with 350 MB test size over it for the 
night.

Everything survived, worked flawlessly and I'm happy my disk did too :-)
Many thanks for the fine work!

Greetings,
Andreas

-- 
->>>----------------------- Andreas Franck --------<<<-
---<<<---- Andreas.Franck@post.rwth-aachen.de --->>>---
->>>---- Keep smiling! ----------------------------<<<-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
