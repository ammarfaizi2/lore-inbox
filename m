Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965002AbVHIWU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965002AbVHIWU3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 18:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965005AbVHIWU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 18:20:28 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:27616 "EHLO
	mta08-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S965006AbVHIWU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 18:20:27 -0400
Message-ID: <42F92C3E.4070803@gentoo.org>
Date: Tue, 09 Aug 2005 23:20:46 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050723)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, mog.johnny@gmx.net
Subject: Re: irqpoll causing some breakage?
References: <42F7FD5E.6000107@gentoo.org>	 <1123605419.15600.35.camel@localhost.localdomain>	 <42F8E3E3.1010201@gentoo.org> <1123625697.19543.4.camel@localhost.localdomain>
In-Reply-To: <1123625697.19543.4.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> What do the other reports look like ?
> 

Here's one:

http://forums.gentoo.org/viewtopic-t-361718-highlight-irqpoll.html

This possibly suggests that the irqpoll patch actually caused a "nobody cared" 
which wasn't there previously. (Now that I have looked closer at the patch, I 
realise how unlikely this is, but this was my reaction at the time!)

I had another report like that by email (another network adapter, "nobody 
cared" message appeared which wasn't there before). The revision difference 
was even smaller and again irqpoll was my suspect. But he never responded to 
my request to test reverting the irqpoll patch and file a bug. I'll dig up the 
email and send a reminder.

Given that I haven't been able to pinpoint irqpoll as the cause of these, I 
don't think you should worry about them at this stage. The only interesting 
one at the moment is the keyboard/mouse thing...

Daniel
