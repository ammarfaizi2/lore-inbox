Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289161AbSBSBGo>; Mon, 18 Feb 2002 20:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289139AbSBSBGf>; Mon, 18 Feb 2002 20:06:35 -0500
Received: from dsl-213-023-040-169.arcor-ip.net ([213.23.40.169]:55185 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S289148AbSBSBGa>;
	Mon, 18 Feb 2002 20:06:30 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Subject: Re: [RFC] Page table sharing
Date: Tue, 19 Feb 2002 02:11:20 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.4.33.0202182000320.5124-100000@coffee.psychology.mcmaster.ca>
In-Reply-To: <Pine.LNX.4.33.0202182000320.5124-100000@coffee.psychology.mcmaster.ca>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16cyoS-0000yG-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 19, 2002 02:01 am, Mark Hahn wrote:
> > [benchmarks]
> >
> > (Look at the last one, the nonshared fork forces the system into swap.  I ran 
> > it twice to verify, the second time from a clean reboot.  This is another 
> > reason why shared page tables are good.)
> 
> that's really nice.  http://hahn.mcmaster.ca/~hahn/shpg.png
> if you like graphs.  but did you swap the last two sets,
> or does a reboot actually make it take longer?

I wouldn't read too much into the variance, swapping is fairly brain-damaged at
the moment.  Please stand by for an update after we kick around the question of
how to repair the swap locking and we'll get better numbers.  They are going to
be in the same ballpark, hopefully with less variance.  Thanks a lot for the
graph.

(I took the liberty of replying to the kernel list.)

-- 
Daniel
