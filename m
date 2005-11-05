Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751468AbVKEL3m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468AbVKEL3m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 06:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbVKEL3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 06:29:42 -0500
Received: from smtp-106-saturday.nerim.net ([62.4.16.106]:14857 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1751468AbVKEL3l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 06:29:41 -0500
Date: Sat, 5 Nov 2005 12:29:58 +0100
From: Jean Delvare <khali@linux-fr.org>
To: hostmaster <hostmaster@ed-soft.at>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: New Linux Development Model
Message-Id: <20051105122958.7a2cd8c6.khali@linux-fr.org>
In-Reply-To: <436C7E77.3080601@ed-soft.at>
References: <436C7E77.3080601@ed-soft.at>
X-Mailer: Sylpheed version 2.0.3 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, huh...

... don't you have a real name? Posting as "hostmaster" may impress
teenagers, but over there we tend to prefer people with real names.

> I tought long about writting this mail. I'm a linux use since many years.
> At the moment i'll getting more then frustrated about the actual develoment
> model of the kernel. In the latest releases things where broken from release
> to release.
> For example take the ipw2200 driver.
>  From 2.6.12 -> 2.6.13 the header file ieee80211.h was incompatible with 
> driver.
> Also transfer speed decreased dramaticaly.
>  From 2.6.13 -> 2.6.14 you included the ipw2200 driver. But in an too 
> old version without WPA support.
> (...)
> I realy liked it to have the latest state of the art kernel, but at the 
> moment i'm forced to use 2.6.12 ( ipw2200 -> WPA ).

Your problems seem to be very specific to wireless networking, right?
Blaming the whole development model because one area seems to have
problems is a bit awkward, don't you think? Report to the persons
responsible for that area and/or specific driver, tell them about the
problem, they'll surely listen to you and improve the process if
possible.

Also, the point you mention for the 2.6.13 -> 2.6.14 transition is
irrelevant with regards to the development model. With a different
development model, the driver wouldn't have been added at all. This
wouldn't have made any difference for you as far as I can see.

> The external driver on ipw2200.sourceforge.net seems not to work
> with 2.6.14.
> (...)
> I had also several problems with some other not in kernel drivers.

Third party drivers don't work, and you complain to us. What's the
point?

> I can't understand it why you have to break compatibility from kernel 
> release to kernel release.

You should read this document:
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=Documentation/stable_api_nonsense.txt

> Don't you think that this makes 3'rd party driver developers
> frustrated?

We don't care. It's their choice, not ours.

> It can't be an option for 3'rd party developers and users to check if 
> external drivers still works with new kenrel releases.

It is. If they are not happy with that, they simply get their code
integrated into the main Linux tree, and get to work with us rather
than apart on their own. It's easier for us, it's easier for them,
and it's easier for the users. Everyone benefits.

> From my point of view the actual linux kernel is far away from a stable 
> development process.

Yet you don't propose anything to improve it?

-- 
Jean Delvare
