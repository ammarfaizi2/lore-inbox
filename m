Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131644AbRCSWhI>; Mon, 19 Mar 2001 17:37:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131643AbRCSWg6>; Mon, 19 Mar 2001 17:36:58 -0500
Received: from relay02.cablecom.net ([62.2.33.102]:40712 "EHLO
	relay02.cablecom.net") by vger.kernel.org with ESMTP
	id <S131642AbRCSWgm>; Mon, 19 Mar 2001 17:36:42 -0500
Message-ID: <3AB689CC.FE5A8AAB@bluewin.ch>
Date: Mon, 19 Mar 2001 23:35:55 +0100
From: Otto Wyss <otto.wyss@bluewin.ch>
Reply-To: otto.wyss@bluewin.ch
X-Mailer: Mozilla 4.76 (Macintosh; U; PPC)
X-Accept-Language: de,en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Linux should better cope with power failure
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Jackson wrote:
> 
> Brian Gerst wrote:
> 
> > "Richard B. Johnson" wrote:
> > >
> > > On Mon, 19 Mar 2001, Otto Wyss wrote:
> > >
> > > > Lately I had an USB failure, leaving me without any access to my system
[..]
> > > Unix and other such variants have what's called a Virtual File System
> > > (VFS).  The idea behind this is to keep as much recently-used file stuff
> > > in memory so that the system can be as fast as if you used a RAM disk
> > > instead of real physical (slow) hard disks. If you can't cope with this,
> > > use DOS.
> >
> > At the very least the disk should be consistent with memory.  If the
> > dirty pages aren't written back to the disk (but not necessarily removed
> > from memory) after a reasonable idle period, then there is room for
> > improvement.
> 
> They are.   If you leave your machine one for a minute or so (probably less is ok,
> but I don't know) the kernel will flush dirty buffers... fsck will complain, but the
> file's

There was at least 15min I waited without doing anything (how could I
without any imput device). I was editing a file with vim and the usual
bunch of demons where running mostly doing nothing. I don't know if all
the complains from fsck where due to open files or dirty cache pages. I
wouldn't complain if there was any heavy activity but there was allmost none.

> *data* blocks will be on the disk.  There are way more reasons that this is a silly
> and annoying thread.  You should read more about things like
> asynchronous/synchronous filesystems,
> lazy-write cacheing, etc, etc,.  If you know how to write software and/or configure
> your system,
> you can avoid all of these problems.  Or use a journaling filesystem ext3/xfs, etc.
> But I tire of this...

So in real live you would propose to put fences and nets everywhere to
prevent children from possibly falling in abyses?

O. Wyss
