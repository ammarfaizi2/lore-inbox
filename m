Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261578AbUKWWUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261578AbUKWWUu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 17:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbUKWWSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 17:18:46 -0500
Received: from alog0306.analogic.com ([208.224.222.82]:36480 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261505AbUKWWRD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 17:17:03 -0500
Date: Tue, 23 Nov 2004 17:15:57 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Karel Kulhavy <clock@twibright.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: description of struct sockaddr
In-Reply-To: <20041123214300.GB2147@beton.cybernet.src>
Message-ID: <Pine.LNX.4.61.0411231711420.8507@chaos.analogic.com>
References: <20041123214300.GB2147@beton.cybernet.src>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2004, Karel Kulhavy wrote:

> Hello
>
> man netdevice talks about struct sockaddr, but neither describes it,
> nor provides a link to descriptio, nor the "SEE ALSO" items
> (ip(7), proc(7), rnetlink(7)) provide the necessary information.
>
> "The hardware address is specified in a struct sockaddr".
>
> Where is struct sockaddr specified?
>

How about /usr/include/sys/socket.h (for starters). If you can
actually find all the member names by following all the
included-includes, you probably get some kind of prize.
Note that the __SOCKADDR_ALLTYPES macro is absolutely
amazing. It's possible to have the pre-processor hide
everything, making trouble-shooting pure art!

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
