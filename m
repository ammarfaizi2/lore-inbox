Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261459AbSJ2BIU>; Mon, 28 Oct 2002 20:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261446AbSJ2BIU>; Mon, 28 Oct 2002 20:08:20 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:37261 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261439AbSJ2BIR>;
	Mon, 28 Oct 2002 20:08:17 -0500
Date: Mon, 28 Oct 2002 17:08:44 -0800
From: Hanna Linder <hannal@us.ibm.com>
To: Davide Libenzi <davidel@xmailserver.org>, bert hubert <ahu@ds9a.nl>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: and nicer too - Re: [PATCH] epoll more scalable than poll
Message-ID: <112700000.1035853724@w-hlinder>
In-Reply-To: <Pine.LNX.4.44.0210281708120.966-100000@blue1.dev.mcafeelabs.com>
References: <Pine.LNX.4.44.0210281708120.966-100000@blue1.dev.mcafeelabs.com>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Monday, October 28, 2002 17:13:53 -0800 Davide Libenzi <davidel@xmailserver.org> wrote:

> On Tue, 29 Oct 2002, bert hubert wrote:
> 
>> Ok, so that is two things that need to be in the manpage and probably in
>> bold:
>> 
>> 	1) epoll only works on pipes and sockets
>>               (not on tty, not on files)
>> 
>>         2) epoll must be used on non-blocking sockets only
>>               (and describe the race that happens otherwise)
>> 
>> If you send me the source of your manpages I'll work it in if you want.
> 
> No problem ...
> 

	If you need any help with the Man pages I will be glad to 
help too. It looks like providing examples of how to use it would be
very useful since this is something application writers are supposed 
to use...

> events after you received EAGAIN or after accept/connect". And the fact on
> using the fd immediately after an accept/connect is enforced by two very
> likely facts :
> 
> 1) on accept() it's very likely that the first packet brough you something
> 	more than SYN
> 
> 2) on connect() you have the full I/O write space available

	Do you think these should be mentioned explicitly?

Thanks a lot.

Hanna

