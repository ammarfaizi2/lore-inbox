Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265816AbTIERle (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 13:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265817AbTIERle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 13:41:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:14790 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265816AbTIERld (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 13:41:33 -0400
Date: Fri, 5 Sep 2003 10:47:49 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Rob Landley <rob@landley.net>
cc: Pavel Machek <pavel@suse.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Fix up power managment in 2.6
In-Reply-To: <200309050158.36447.rob@landley.net>
Message-ID: <Pine.LNX.4.44.0309051044470.17174-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Is there somewhere we can download your code?  swsusp in -test3 hung my box 
> immediately without touching the disk, and in -test4 there doesn't seem to be 
> any way to trigger it under /proc or /sys...

I posted a URL last Saturday to the patch, and Andrew merged it into 
-test4-mm4. 

If you're interested in testing, please try -test4-mm6, as it has a couple 
of more fixes. 

> APM suspend doesn't work properly on my new thinkpad (suspends but hangs with 
> the power LED still on and the hibernate light off, and the thing's a brick 
> at that point; the only thing you can do is hold the power button down for 
> ten seconds or pop the battery to get it to boot back up from scratch.)  So I 
> have to shut the sucker down every time I want to move it, which is a pain...

What model is it? It probably doesn't support APM at all. I can't
guarantee that ACPI suspend/resume will work on it, but I'm interested to 
see if it does.. 

Thanks,


	Pat

