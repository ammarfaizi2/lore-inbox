Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130368AbQLPWY4>; Sat, 16 Dec 2000 17:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130375AbQLPWYq>; Sat, 16 Dec 2000 17:24:46 -0500
Received: from [194.213.32.137] ([194.213.32.137]:1796 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S130367AbQLPWYc>;
	Sat, 16 Dec 2000 17:24:32 -0500
Message-ID: <20001215233147.E9506@bug.ucw.cz>
Date: Fri, 15 Dec 2000 23:31:47 +0100
From: Pavel Machek <pavel@suse.cz>
To: Heiko.Carstens@de.ibm.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CPU attachent and detachment in a running Linux system
In-Reply-To: <C12569B3.0024DA06.00@d12mta01.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <C12569B3.0024DA06.00@d12mta01.de.ibm.com>; from Heiko.Carstens@de.ibm.com on Tue, Dec 12, 2000 at 07:42:29AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I still wonder what you and other people think about the idea of an
> interface where the parts of the kernel with per-cpu dependencies should
> register two functions...

Why not compile kernel with structeres big enough for 32 processors,
and then just add CPUs up to the limit without changing anything?
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
