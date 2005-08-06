Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263411AbVHFTBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263411AbVHFTBf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 15:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263412AbVHFTBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 15:01:35 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:41605 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S263411AbVHFTBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 15:01:34 -0400
Message-ID: <42F5090E.4070608@gmail.com>
Date: Sat, 06 Aug 2005 21:01:34 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Simon Morgan <sjmorgan@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Outdated Sangoma Drivers
References: <de63970c05080602496c2c8b11@mail.gmail.com>
In-Reply-To: <de63970c05080602496c2c8b11@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon Morgan napsal(a):

>Hi,
>
>I couldn't help noticing that the Sangoma drivers distributed with the
>current kernel are slightly out of date and was wondering whether there
>was any reason for this?
>
>For example the kernel copy of sdla.c was last updated Mar 20, 2001 while
>the version contained in the drivers distributed on sangoma.com[1] was
>last updated Dec 15. 2003.
>
Hi,
this is letter from sangoma:
<cite>
the sdla.c is not Sangoma's file :) or if it is it should be erased.  
The sdla.c
has not been used since 2001.

It is true that wanpipe drivers are not part of linux 2.6 kernel.  We have
been so busy developing that there is no way the linux kernel could
keep up with the changes.

Bottom line we have to put a whole new wanpipe driver into the kernel
source, and that is a big task.
It is much easier for us to ask people to use our drivers from the web.
Once the wanpipe drivers stop changing so fast we will be able
to push the new release into the kernel.  It doesn't make sense to do it 
now
because if anyone wants to use wanpipe, that person would have to
get the latest drivers from the web!
</cite>

So what do you think we would do?
Add some lines to Kconfig with address of ftp sangoma?
Delete old version from the tree and wait for the new one?
