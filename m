Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262029AbVAJBKG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbVAJBKG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 20:10:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbVAJBKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 20:10:06 -0500
Received: from mx.freeshell.org ([192.94.73.21]:9199 "EHLO sdf.lonestar.org")
	by vger.kernel.org with ESMTP id S262029AbVAJBKC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 20:10:02 -0500
Date: Mon, 10 Jan 2005 01:09:45 +0000 (UTC)
From: Roey Katz <roey@sdf.lonestar.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 & 2.6.10 unresponsive to keyboard upon bootup
In-Reply-To: <200501091102.51246.dtor_core@ameritech.net>
Message-ID: <Pine.NEB.4.61.0501100107070.13360@sdf.lonestar.org>
References: <Pine.NEB.4.61.0501010814490.26191@sdf.lonestar.org>
 <200501090035.07247.dtor_core@ameritech.net> <Pine.NEB.4.61.0501091421530.22271@sdf.lonestar.org>
 <200501091102.51246.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I moved that input/serio line to be just above the line mentioning 
"input".  Rebooted;  still got this error.  See all the -2.6.9-rc2-bk3 
logs on my web site (http://roey.freeshell.org/mystuff/kernel/) for 
details. I will follow up with psmouse disabled if you want.


Roey
PS: just changing a Makefile makes a difference?


> Most likely you selected and then pasted the patch while in X. This caused
> whitespace damage to the patch (tabs were converted to spaces). Try saving
> the entire message into a file with your MUA and feed the result to the
> "patch" command.
>
> Alternatively, just edit drivers/Makefile and move the line mentioning
> "input/serio" to be just above the line mentioning "input".
>
