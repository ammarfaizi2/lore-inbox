Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269797AbRHDFSv>; Sat, 4 Aug 2001 01:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269798AbRHDFSl>; Sat, 4 Aug 2001 01:18:41 -0400
Received: from erasmus.off.net ([64.39.30.25]:14857 "HELO erasmus.off.net")
	by vger.kernel.org with SMTP id <S269797AbRHDFSZ>;
	Sat, 4 Aug 2001 01:18:25 -0400
Date: Sat, 4 Aug 2001 01:18:38 -0400
From: Zach Brown <zab@zabbo.net>
To: Dan Kegel <dank@kegel.com>
Cc: Petru Paler <ppetru@ppetru.net>, Christopher Smith <x@xman.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Davide Libenzi <davidel@xmailserver.org>
Subject: Re: Could /dev/epoll deliver aio completion notifications? (was: Re: sigopen() vs. /dev/sigtimedwait)
Message-ID: <20010804011838.W3034@erasmus.off.net>
In-Reply-To: <3B6B50C4.D9FBF398@kegel.com> <20010803183853.H1080@ppetru.net> <3B6B59AF.9826F928@kegel.com> <3B6B662F.3E83C22F@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3B6B662F.3E83C22F@kegel.com>; from dank@kegel.com on Fri, Aug 03, 2001 at 08:04:15PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On the other hand, if /dev/epoll were flexible enough that it could
> deliver AIO completion notifications, 

As far as I know, Ben LaHaise (bcrl@redhat.com) already has a fine
method conceived for receiving batches of async completion, including an
"async poll".  It should give the sort of behaviour you want and is also
useful for other AIO things, obviously :)

You should really chat with him.

- z
