Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130022AbRAPK25>; Tue, 16 Jan 2001 05:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130337AbRAPK2r>; Tue, 16 Jan 2001 05:28:47 -0500
Received: from [194.213.32.137] ([194.213.32.137]:1028 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S130022AbRAPK2e>;
	Tue, 16 Jan 2001 05:28:34 -0500
Message-ID: <20010116001633.A3343@bug.ucw.cz>
Date: Tue, 16 Jan 2001 00:16:33 +0100
From: Pavel Machek <pavel@suse.cz>
To: jamal <hadi@cyberus.ca>, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <Pine.GSO.4.30.0101141237020.12354-100000@shell.cyberus.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.GSO.4.30.0101141237020.12354-100000@shell.cyberus.ca>; from jamal on Sun, Jan 14, 2001 at 01:29:22PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> TWO observations:
> - Given Linux's non-pre-emptability of the kernel i get the feeling that
> sendfile could starve other user space programs. Imagine trying to send a
> 1Gig file on 10Mbps pipe in one shot.

Hehe, try sigkilling process doing that transfer. Last time I tried it
it did not work.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
