Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269155AbRGaBfe>; Mon, 30 Jul 2001 21:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269152AbRGaBfR>; Mon, 30 Jul 2001 21:35:17 -0400
Received: from marine.sonic.net ([208.201.224.37]:39531 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S269147AbRGaBey>;
	Mon, 30 Jul 2001 21:34:54 -0400
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Mon, 30 Jul 2001 18:35:01 -0700
From: Mike Castle <dalgoda@ix.netcom.com>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: ext3-2.4-0.9.4
Message-ID: <20010730183500.A437@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010731025700.G28253@emma1.emma.line.org>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, Jul 31, 2001 at 02:57:00AM +0200, Matthias Andree wrote:
> So, please tell my why Single Unix Specification v2 specifies EIO for
> rename. Asynchronous I/O cannot possibly trigger immediate EIO.

It also specifies EIO as possible for write().

Are you saying that, since SUS2 specifies that write() is capable of
returning EIO, and asynchronous I/O cannot possibly trigger immediate EIO, 
that all calls to write() should by synchronous?

mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
