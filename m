Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130697AbQKJVU4>; Fri, 10 Nov 2000 16:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130892AbQKJVUq>; Fri, 10 Nov 2000 16:20:46 -0500
Received: from [194.213.32.137] ([194.213.32.137]:772 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S130697AbQKJVU2>;
	Fri, 10 Nov 2000 16:20:28 -0500
Message-ID: <20001110224808.A443@bug.ucw.cz>
Date: Fri, 10 Nov 2000 22:48:08 +0100
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>, jaharkes@cs.cmu.edu
Cc: jaharkes@cs.cmu.edu
Subject: [BUG] coda went from c 67 5 to c 67 0 [was Re: mount -tcoda /dev/cfs0 /mnt no longer works in -test9 and newer?]
In-Reply-To: <20001106103539.A343@bug.ucw.cz> <20001107134841.A31058@cs.cmu.edu> <20001110213911.A300@bug.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20001110213911.A300@bug.ucw.cz>; from Pavel Machek on Fri, Nov 10, 2000 at 09:39:11PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I found where problem with coda lies: it went from character device at
67:5 to character device at 67:0. Ouch, ugly. Is it bug or what?
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
