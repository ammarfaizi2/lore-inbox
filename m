Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbWBSTSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbWBSTSK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 14:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbWBSTSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 14:18:09 -0500
Received: from ms-smtp-03-smtplb.tampabay.rr.com ([65.32.5.133]:21745 "EHLO
	ms-smtp-03.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S932224AbWBSTSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 14:18:08 -0500
Message-ID: <43F8C464.3000509@cfl.rr.com>
Date: Sun, 19 Feb 2006 14:17:56 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Mail/News 1.5 (X11/20060119)
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
CC: Pavel Machek <pavel@suse.cz>, Kyle Moffett <mrmacman_g4@mac.com>,
       Alon Bar-Lev <alon.barlev@gmail.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Flames over -- Re: Which is simpler?
References: <Pine.LNX.4.44L0.0602191138470.9165-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0602191138470.9165-100000@netrider.rowland.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern wrote:
> 
> I'm confused.  Weren't you arguing, only a few days ago, that it _should_
> be okay to unplug a USB drive while the system is suspended?  After all,

No, I wasn't arguing that it should be okay to unplug a usb drive while 
the system is suspended, I was saying that it is better for the kernel 
to assume you did not when it can't really tell, since you aren't 
supposed to do that anyhow.

> since there's no difference (as far as the kernel can see) between power
> loss on the bus and an actual unplug, you can hardly say that one should
> be allowed and the other not.

   But there _IS_ a difference between power loss and actual unplug, so 
I very well can say one is allowed and the other is not.  The fact that 
the kernel can not tell the difference is simply a limitation that must 
be dealt with.


