Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131339AbRAaLkm>; Wed, 31 Jan 2001 06:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131341AbRAaLkZ>; Wed, 31 Jan 2001 06:40:25 -0500
Received: from [194.213.32.137] ([194.213.32.137]:2052 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S131339AbRAaLkR>;
	Wed, 31 Jan 2001 06:40:17 -0500
Message-ID: <20010129225007.A1214@bug.ucw.cz>
Date: Mon, 29 Jan 2001 22:50:08 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>
Cc: leitner@fefe.de
Subject: Re: sendfile+zerocopy: fairly sexy (nothing to do with ECN)
In-Reply-To: <3A726087.764CC02E@uow.edu.au> <200101271854.VAA02845@ms2.inr.ac.ru> <3A73AF7B.6610B559@uow.edu.au> <20010128143748.A9767@convergence.de> <20010128152725.A13600@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20010128152725.A13600@gruyere.muc.suse.de>; from Andi Kleen on Sun, Jan 28, 2001 at 03:27:25PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Advantage of Tulip and AMD is that they perform much better in my experience
> on half duplex Ethernet than other cards because they a modified 
> patented backoff scheme. Without it Linux 2.1+ tends to suffer badly from
> ethernet congestion by colliding with the own acks, probably because it 
> sends too fast.

Is that real problem? If so, some strategic delay loop should do the
trick...
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
