Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314602AbSEYOVm>; Sat, 25 May 2002 10:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314609AbSEYOVl>; Sat, 25 May 2002 10:21:41 -0400
Received: from [80.120.128.82] ([80.120.128.82]:48146 "EHLO hofr.at")
	by vger.kernel.org with ESMTP id <S314602AbSEYOVl>;
	Sat, 25 May 2002 10:21:41 -0400
From: Der Herr Hofrat <der.herr@mail.hofr.at>
Message-Id: <200205251326.g4PDQot16579@hofr.at>
Subject: Re: can't find startup messages since april in /var/log/messages using
 2.4.18
In-Reply-To: <3a.2744d23a.2a20b7ec@aol.com> from "Floydsmith@aol.com" at "May
 25, 2002 05:48:28 am"
To: Floydsmith@aol.com
Date: Sat, 25 May 2002 15:26:50 +0200 (CEST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> For some strange reason I can't find where my "startup messagges" are being 
> stored. I booted up twice this morning (052502) and only get only 1 line in 
> /var/log/messages which is:
> May 25 05:10:05 localhost syslogd 1.3-3: restart.
> 
> All boots since April 11 have only one such entry recorded. "dmesg" and a 
> "vi" of "messages" show a full log journal for April 11.
> I have did a "df" and all file sytems have free space.
> 
> Of course, the meesages do appear on the console at startup.
> 
> Any suggestions?
>
check your init scripts , you might have some entry/error in /etc/rc.d/boot (or where ever you init scripts lie that clears the buffer befor syslogd/klogd get started. (my /etc/init.d/boot does dmesg -c > /var/log/boot.msg so I get the relevant messages during operation without screens of boot up infos, no boot messages in /var/log/messages this way ither.)

hofrat
