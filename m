Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266771AbUBMNzV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 08:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266784AbUBMNzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 08:55:21 -0500
Received: from denise.shiny.it ([194.20.232.1]:64972 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id S266771AbUBMNzR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 08:55:17 -0500
Message-ID: <XFMail.20040213145513.pochini@shiny.it>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20040213124232.B2871@pclin040.win.tue.nl>
Date: Fri, 13 Feb 2004 14:55:13 +0100 (CET)
From: Giuliano Pochini <pochini@shiny.it>
To: Andries Brouwer <aebr@win.tue.nl>
Subject: Re: PATCH, RFC: 2.6 Documentation/Codingstyle
Cc: linux kernel <linux-kernel@vger.kernel.org>
Cc: linux kernel <linux-kernel@vger.kernel.org>,
       Michael Frank <mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 13 Feb 2004, Andries Brouwer wrote:

> I do. (That is, 80xN with N in 24..60 or so.)
>
> The 80 here has a pedagogical and a practical purpose.
> The practical one is that it makes sure that everybody can read the source.
> The pedagogical is to invite you to arrange the code in a different way
> if you are nesting too deeply or your expressions are too complicated.

Deeply nested doesn't mean unreadable or badly structured. 1 tab in the
function, 1tab a switch, 1 if, 1 for, 1 if and you have already lost
half of the available space. It's not difficult to find lines compressed
towards the 79th column in the kernel sources.
I propose to change "hard limit" to "soft limit" to avoid things like this:

                                rc=idefloppy_begin_format(drive, inode,
                                                              file,
                                                              (int *)arg);

IMO we should try to keep function calls on the same line. btw it's
only a matter of taste and the compiler accepts ugly code too :))

> There is also ergonomics. There is a reason newspapers do not print
> text across the full width of the page - it would be very difficult
> to read.
  
Code has only one instruction per line.
  
  
--
Giuliano.

