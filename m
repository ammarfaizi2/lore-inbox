Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270492AbTGNBpV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 21:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270495AbTGNBpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 21:45:21 -0400
Received: from smtp1.clear.net.nz ([203.97.33.27]:5816 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S270492AbTGNBpP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 21:45:15 -0400
Date: Mon, 14 Jul 2003 13:57:42 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: [Swsusp-devel] Re: Thoughts wanted on merging Software Suspend
	enhancements
In-reply-to: <20030714015531.7F1CF14829@o-o.yi.org>
To: Lyle Seaman <lws@o-o.yi.org>
Cc: swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1058147861.2400.13.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <20030714015531.7F1CF14829@o-o.yi.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Of course there's also the possibility that suspending might abort due
to, say, being unable to freeze all the processes or having no swap
available.

In a situation like that, I wouldn't walk away until I saw it power
down. Besides, we're only talking about waiting 10 or 20 seconds in most
cases (depending on the system's configuration). If you care that much
about the security of your system, you'll be willing to wait.

Regards,

Nigel

On Mon, 2003-07-14 at 13:55, Lyle Seaman wrote:
> > Haven't you ever pressed the "off" or "lock" button on a computer in a
> > lab and walked away?
> 
> Yes, I have, but that's not what I was driving at.  The question is, what do 
> you think is the difference between :
> 
> (a) pressing "suspend" and walking away, while being assured that suspend will 
> complete and leave the system ... suspended, until someone triggers a "resume"
> 
> and
> 
> (b) pressing "suspend" and walking away, while allowing the possibility that 
> someone might interrupt the suspend operation.
> 
> ??
> 
> Personally, I don't see any difference.
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

You see, at just the right time, when we were still powerless,
Christ died for the ungodly.
	-- Romans 5:6, NIV.

