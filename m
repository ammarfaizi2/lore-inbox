Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262919AbSJGIdz>; Mon, 7 Oct 2002 04:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262925AbSJGIdy>; Mon, 7 Oct 2002 04:33:54 -0400
Received: from denise.shiny.it ([194.20.232.1]:38623 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S262919AbSJGIdy>;
	Mon, 7 Oct 2002 04:33:54 -0400
Message-ID: <XFMail.20021007103901.pochini@shiny.it>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <200210060130.g961UjY2206214@pimout2-ext.prodigy.net>
Date: Mon, 07 Oct 2002 10:39:01 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: Rob Landley <landley@trommello.org>
Subject: RE: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 n
Cc: linux-kernel@vger.kernel.org, "Martin J. Bligh" <mbligh@aracnet.com>,
       Linus Torvalds <torvalds@transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> important, but in reality an awful lot of the windows "look and feel" issues 
> boil down to the simple fact that enough of their windowing system is welded 
> into the kernel that their mouse pointer keeps updating smoothly no matter 
> how  heavily loaded the system is, and when you click on a window its Z-order 
> gets  promoted snappily under just about all circumstances.  That's it.

I feel linux more responsive than M$ windos. But AmigaOS was better. In
AmigaOS the GUI was handled is a different way. UI, widgets, windows, etc.
run in a separate process, so even if the application is busy you can press
buttons, and the events are queued. GTK, QT, etc.. have a different behaviour
and you can't interact with the UI while the application is busy. It is
possible, but it requires a lot of extra work for the developer and almost
nobody does it. To get more GUI responsiveness, the right way is to change
UI toolkits. The kernel works just fine now.

And about sound skipping, I found that libtool is the most offender. I
don't know why (it's a shell script...), but it it. It causes a short
pause of everything. I use a ppc, perhaps on other archs it's harmless.


Bye.

