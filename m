Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319299AbSIKTOA>; Wed, 11 Sep 2002 15:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319300AbSIKTOA>; Wed, 11 Sep 2002 15:14:00 -0400
Received: from chaos.analogic.com ([204.178.40.224]:27526 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S319299AbSIKTN7>; Wed, 11 Sep 2002 15:13:59 -0400
Date: Wed, 11 Sep 2002 15:21:37 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Oliver Neukum <oliver@neukum.name>
cc: Xuan Baldauf <xuan--reiserfs@baldauf.org>,
       Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Heuristic readahead for filesystems
In-Reply-To: <200209112104.41987.oliver@neukum.name>
Message-ID: <Pine.LNX.3.95.1020911151848.32205A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Sep 2002, Oliver Neukum wrote:

> Am Mittwoch, 11. September 2002 20:43 schrieb Xuan Baldauf:
> 
> > > Please correct me, if I am wrong, but wouldn't read() block ?
> >
> > AFAIK, "man open" tells
> >
> > [...]
> >       int open(const char *pathname, int flags);
> > [...]
> >        O_NONBLOCK or O_NDELAY
> >                The file is opened in non-blocking mode. Neither the open
> > nor any __subsequent__ operations  on  the  file  descriptor
> >                which is returned will cause the calling process to wait.
> > [...]
> >
> > So read won't block if the file has been opened with O_NONBLOCK.
> 
> Well, so the man page tells you. The kernel sources tell otherwise, unless
> I am badly mistaken.
> 
> > > Aio should be able to do it. But even that want help you with the stat
> > > data.
> >
> > Aio would help me announcing stat() usage for the future?
> 
> No, it won't. But it would solve the issue of reading ahead.
> Stating needs a kernel implementation of 'stat ahead'
> -

I think this is discussed in the future. Write-ahead is the
next problem solved. ?;)

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

