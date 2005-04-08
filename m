Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262888AbVDHR2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262888AbVDHR2n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 13:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262892AbVDHR0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 13:26:36 -0400
Received: from relay1.tiscali.de ([62.26.116.129]:8418 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S262888AbVDHRZ0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 13:25:26 -0400
Message-ID: <4256BE7D.5040308@tiscali.de>
Date: Fri, 08 Apr 2005 19:25:17 +0200
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050406)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrea Arcangeli <andrea@suse.de>, Chris Wedgwood <cw@f00f.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org> <20050408041341.GA8720@taniwha.stupidest.org> <Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org> <20050408071428.GB3957@opteron.random> <Pine.LNX.4.58.0504080724550.28951@ppc970.osdl.org> <4256AE0D.201@tiscali.de> <Pine.LNX.4.58.0504081010540.28951@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504081010540.28951@ppc970.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>On Fri, 8 Apr 2005, Matthias-Christian Ott wrote:
>  
>
>>SQL Databases like SQLite aren't slow.
>>    
>>
>
>After applying a patch, I can do a complete "show-diff" on the kernel tree
>to see the effect of it in about 0.15 seconds.
>
>Also, I can use rsync to efficiently replicate my database without having 
>to re-send the whole crap - it only needs to send the new stuff.
>
>You do that with an sql database, and I'll be impressed.
>
>		Linus
>
>  
>
Ok, but if you want to search for information in such big text files it 
slow, because you do linear search -- most datases use faster search 
algorithms like hashing and if you have multiple files (I don't if 
you're system uses multiple files (like bitkeeper) or not) which need a 
system call to be opened this will be very slow, because system calls 
itself are slow. And using rsync is also possible because most databases 
store their information as plain text with meta information.

Mattthias-Christian Ott
