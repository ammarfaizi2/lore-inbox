Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264264AbRFLIji>; Tue, 12 Jun 2001 04:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264271AbRFLIj3>; Tue, 12 Jun 2001 04:39:29 -0400
Received: from [194.213.32.142] ([194.213.32.142]:2308 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S264260AbRFLIjX>;
	Tue, 12 Jun 2001 04:39:23 -0400
Message-ID: <20010611223357.A959@bug.ucw.cz>
Date: Mon, 11 Jun 2001 22:33:57 +0200
From: Pavel Machek <pavel@suse.cz>
To: =?iso-8859-1?Q?Mich=E8l_Alexandre_Salim?= <salimma1@yahoo.co.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: Clock drift on Transmeta Crusoe
In-Reply-To: <20010611113604.4073.qmail@web3504.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: =?iso-8859-1?Q?=3C20010611113604=2E4073=2Eqmail=40web3504=2Email=2Eyahoo?=
 =?iso-8859-1?Q?=2Ecom=3E=3B_from_Mich=E8l_Alexandre_Salim_on_Mon=2C_Jun_?=
 =?iso-8859-1?Q?11=2C_2001_at_12:36:04PM_+0100?=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI!

> Searching through the mailing list I could not find a
> reference to this problem, hence this post.
> 
> Having ran various kernel and distribution
> combinations (SGI's 2.4.2-xfs bundled with their Red
> Hat installer, 2.4-xfs-1.0 and 2.4 CVS trees, Linux
> Mandrake with default kernel 2.4.3, and lastly
> 2.4.5-ac9), compiled for generic i386 and/or Transmeta
> Crusoe with APM off or on, one thing sticks out : a
> clock drift of a few minutes per day.
> 
> This problem might not be noticeable for most users
> since notebooks are not normally left running that
> long, but it is rather serious. I can choose not to
> sync the software and hardware clock on shutdown and
> re-read the hardware clock every hour or so but it is
> rather kludgy.
> 
> Any suggestions and/or user experiences more than
> welcome.

Let me guess: vesafb?

If problem goes away when you stop using framebuffer (i.e. go X), then
it is known. 

You are lucky. My machine is able to loose 2 minutes from every 3
minutes.

try time cat /etc/termcap, and check it against stopwatch.
 								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
