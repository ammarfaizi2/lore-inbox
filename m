Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130241AbRBZP2T>; Mon, 26 Feb 2001 10:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130263AbRBZP2A>; Mon, 26 Feb 2001 10:28:00 -0500
Received: from agnus.shiny.it ([194.20.232.6]:59652 "EHLO agnus.shiny.it")
	by vger.kernel.org with ESMTP id <S130241AbRBZP16>;
	Mon, 26 Feb 2001 10:27:58 -0500
Message-ID: <XFMail.010226162752.pochini@shiny.it>
X-Mailer: XFMail 1.3 [p0] on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Date: Mon, 26 Feb 2001 16:27:52 +0100 (CET)
From: Giuliano Pochini <pochini@shiny.it>
To: linux-kernel@vger.kernel.org
Subject: Re: 128MB lost... where ?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>when you compile your 2.4.x kernel make sure you set the "4G of RAM"
>option, i.e. CONFIG_HIGHMEM4G. If you chose "up to 1G" then it means "up
>to 986M" (or something like that) -- the number in Help is just rounded up
>to confuse the dummy user :)

Ok, I tried it, but it doesn't boot. It doesn't show errors during
init, but then it can't execute anything. The boot sequence stops with
"cannot exec modprobe...." repeated hundreds times.
Yes, modutils are the latest version.

(ASUS cur-dls, dual-833. It runs a Slackware 7.1 + some updates.
Kernel 2.4.2-SMP compiled with egcs-2.91.66.)


Bye.
    Giuliano Pochini ->)|(<- Shiny Corporation {AS6665} ->)|(<-

