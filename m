Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132604AbRDBHSc>; Mon, 2 Apr 2001 03:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132611AbRDBHSW>; Mon, 2 Apr 2001 03:18:22 -0400
Received: from agnus.shiny.it ([194.20.232.6]:43271 "EHLO agnus.shiny.it")
	by vger.kernel.org with ESMTP id <S132604AbRDBHSN>;
	Mon, 2 Apr 2001 03:18:13 -0400
Message-ID: <XFMail.010402091450.pochini@shiny.it>
X-Mailer: XFMail 1.3 [p0] on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20010401124958.A13901@kotako.analogself.com>
Date: Mon, 02 Apr 2001 09:14:50 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: Jag <agrajag@linuxpower.org>
Subject: Re: Temporary disk space leak
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Was the 750M file opened by a program when it was deleted ?

No, I ripped two times the image from a few audio CDs with
cdparanoia -Z to see if my new 2nd-hand cdrom worked fine. I
just did grab, cmp, rm.

> When a file
> is deleted, if it is opened, it will still be there and taking up file
> space (as shown in df) until it is completely closed.

Yes, I know posix, but I don't think this is the case. I'll try reproduce
it...


Bye.
    Giuliano Pochini ->)|(<- Shiny Network {AS6665} ->)|(<-

