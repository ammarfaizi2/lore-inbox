Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262034AbTEYMER (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 08:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262037AbTEYMER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 08:04:17 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:38028 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S262034AbTEYMEQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 08:04:16 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] ide-ops:1262 in 2.4.21-rc3
Mail-Copies-To: never
References: <87d6i7kzcn.fsf@free.fr>
From: Roland Mas <roland.mas@free.fr>
Date: Sun, 25 May 2003 14:17:20 +0200
In-Reply-To: <87d6i7kzcn.fsf@free.fr> (Roland Mas's message of "Sun, 25 May
 2003 14:03:20 +0200")
Message-ID: <878ysvkypb.fsf@free.fr>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Mas, 2003-05-25 14:03:20 +0200 :

>   The problem happens when I try to blank a CD-RW from a terminal in
> X-Window (or from a GUI frontend such as gcombust).  The same
> command issued on the console does not cause the panic.  I'll check
> whether it does if issued on the console when X is running.  The
> problem started happening when I reordered my IDE devices: [...]

[A few crashes later]

It turns out that I was wrong.  The problem seems not to be X, but a
CD player applet (Gnome).  When it runs, any CD burning operation
causes a panic.  When it does not, burning and blanking works fine,
gcombust or not.  I was probably mislead into my former diagnosis by
the fact that I only recently started using that applet, same as I
only recently set up the RAID and moved disks around.

  Anyway, the bug's still there, and I'm still willing to provide more
info on demand.

Roland.
-- 
Roland Mas

Twenty thousand balls, clubs, and rings.  How about yours?
European Juggling Convention -- Svendborg, Denmark.  http://ejc2003.dk
