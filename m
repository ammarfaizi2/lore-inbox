Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263823AbTJ1Bf4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 20:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263824AbTJ1Bf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 20:35:56 -0500
Received: from smtp2.clear.net.nz ([203.97.37.27]:23997 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S263823AbTJ1Bfy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 20:35:54 -0500
Date: Tue, 28 Oct 2003 14:35:40 +1300
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: [pm] fix time after suspend-to-*
In-reply-to: <Pine.LNX.4.44.0310271535160.13116-100000@cherise>
To: Patrick Mochel <mochel@osdl.org>
Cc: George Anzinger <george@mvista.com>, Pavel Machek <pavel@suse.cz>,
       John stultz <johnstul@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1067304940.1696.12.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <Pine.LNX.4.44.0310271535160.13116-100000@cherise>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a suspend script that has been developed for the 2.4 version.
It should be pretty easy to adapt it for the 2.6 versions. Available at
www.sourceforge.net/projects/swsusp.

Regards,

Nigel

On Tue, 2003-10-28 at 12:43, Patrick Mochel wrote:
> > Ok, but then is there some sort of house cleaning that happens to clean up the 
> > mess?  I am thinking something like the run level change where scripts might run 
> > to "fix" things.
> > 
> > Now it could be that my ignorance is showing here, possibly this is all being 
> > done already...
> 
> No, it's not. But, it should. 
> 
> Userspace behavior on suspend transitions is still a bit fuzzy at best. I 
> am beginning to look at userspace requirements, so if anyone wants to send 
> me suggestions, no matter how trivial or wacky, please feel free (on- or 
> off-list). 
> 
> Thanks,
> 
> 
> 	Pat
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.

