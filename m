Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130322AbQLPWZq>; Sat, 16 Dec 2000 17:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130315AbQLPWZ1>; Sat, 16 Dec 2000 17:25:27 -0500
Received: from [194.213.32.137] ([194.213.32.137]:2564 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S130128AbQLPWZO>;
	Sat, 16 Dec 2000 17:25:14 -0500
Message-ID: <20001215234037.F9506@bug.ucw.cz>
Date: Fri, 15 Dec 2000 23:40:37 +0100
From: Pavel Machek <pavel@suse.cz>
To: stewart@neuron.com, Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kapm-idled : is this a bug?
In-Reply-To: <Pine.LNX.4.21.0012111315350.4808-100000@duckman.distro.conectiva> <Pine.LNX.4.10.10012111343570.2897-100000@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.LNX.4.10.10012111343570.2897-100000@localhost>; from stewart@neuron.com on Mon, Dec 11, 2000 at 01:56:22PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Technical merits and voter intent aside, this behavior is misleading and
> inconsistent with previous kernels. Tools like top or a CPU dock applet show
> a constantly loaded CPU. Hacking them to deduct the load from 'kapm-idled'
> seems like the wrong answer.

I guess we should just put even normal idle thread to be visible in
ps. It is cleaner design, anyway.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
