Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262960AbTCKQAX>; Tue, 11 Mar 2003 11:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262961AbTCKQAX>; Tue, 11 Mar 2003 11:00:23 -0500
Received: from denise.shiny.it ([194.20.232.1]:19165 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S262960AbTCKQAW>;
	Tue, 11 Mar 2003 11:00:22 -0500
Message-ID: <XFMail.20030311171056.pochini@shiny.it>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.50.0303101139520.1922-100000@blue1.dev.mcafeelabs.com>
Date: Tue, 11 Mar 2003 17:10:56 +0100 (CET)
From: Giuliano Pochini <pochini@shiny.it>
To: Davide Libenzi <davidel@xmailserver.org>
Subject: RE: [patch, rfc] lt-epoll ( level triggered epoll ) ...
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 10-Mar-2003 Davide Libenzi wrote:
>
> During the last three months I spent considerable amount of time explainig
> developers how edge triggered APIs works, and how to use epoll inside
> their apps. It's time for me to face the reality, that is that:
>
> 1) developers not quite understand ET APIs
> 2) most existing apps are written using LT APIs

1) is easily solvable writing a good FAQ. "Developers" who really
can't undestand edge triggered APIs will continue to use poll().
If ET il faster than LT, tell people to stop whining and to learn
the API. Otherwise choose LT, mainly because of 2), but also
because ET API is more subtle bug prone.


Bye.

