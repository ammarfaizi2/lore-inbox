Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265423AbTAWRRx>; Thu, 23 Jan 2003 12:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265470AbTAWRRw>; Thu, 23 Jan 2003 12:17:52 -0500
Received: from [66.70.28.20] ([66.70.28.20]:50450 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S265423AbTAWRRw>; Thu, 23 Jan 2003 12:17:52 -0500
Date: Thu, 23 Jan 2003 18:26:50 +0100
From: DervishD <raul@pleyades.net>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Tom Sanders <developer_linux@yahoo.com>, redhat-list@redhat.com,
       linux-kernel@vger.kernel.org, redhat-devel-list@redhat.com
Subject: Re: Linux application level timers?
Message-ID: <20030123172650.GA104@DervishD>
References: <20030122221703.42913.qmail@web9806.mail.yahoo.com> <3E301833.8030103@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3E301833.8030103@nortelnetworks.com>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Chris and Tom :))

> >Which Linux timer facility can be used for this?
> I used setitimer for a similar task.  Since you can only have one timer 
> going at any given time, I set up a linked list of timing events, with 
> each event's timeout expressed as a delta from the previous event.

    Tom, if you're interested, I coded a timer multiplexor for Linux
(user space, I mean) a time ago, and although it hasn't been released
yet, has been in use for a year in The Puto Amo Window Manager, so I
think it is pretty stable. It's GPL'd, but not released yet because
it lacks documentation by now and I want to change a couple of
things.

    If you want, I can attach you the code (is pretty simple), or
even better, you can go to www.pleyades.net/~pawm, download the
window manager and pick the code from there (is a bit more updated
that mine, since has a couple of contributions). The file is called
timux.[c,h], and needs too the file chain.c for the data container.
Just let me know. And count on any help you need with TiMux ;))

    Raúl
