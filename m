Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264092AbTDOVVH (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 17:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264089AbTDOVVH 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 17:21:07 -0400
Received: from smtp2.clear.net.nz ([203.97.37.27]:51679 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S264086AbTDOVU7 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 17:20:59 -0400
Date: Wed, 16 Apr 2003 09:33:32 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: New Software Suspend Patch for testing.
In-reply-to: <Pine.LNX.4.44.0304151246400.912-100000@cherise>
To: Patrick Mochel <mochel@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>
Message-id: <1050442411.2983.5.camel@laptop-linux.cunninghams>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <Pine.LNX.4.44.0304151246400.912-100000@cherise>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2003-04-16 at 08:06, Patrick Mochel wrote:
> I have a (fairly large) request: 
> 
> Would you mind updating Documentation/swsusp.txt (and moving it to 
> Documentation/power/swsusp.txt)? 

Okay. I've been meaning to update it.
> 
> Frankly, the code is a mess and difficult to follow. It's also poorly
> commented. I spent the time about a month ago unwinding and deciphering 
> it. Unfortunately, my work conflicts heavily with the work that you're 
> doing, and the lack of documentation describing the intent of the code 
> makes it difficult to make sane judgements of it. 

One more problem is that you're also trying to follow a moving target
:>. In response to Pavel's last request, I'm preparing to work toward
using a linked list for the meta information (to allow unlimited image
size), and at the request of others, compressing (zlib) the saved pages
to make the image faster to save/load.

As to the layout and documentation, I hate them too. I had to keep
things as similar as possible to existing code to make merging easier,
but now that I'm merged with the 2.4 code, perhaps I can do some
cleanups.

Regards,

Nigel

