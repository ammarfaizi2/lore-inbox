Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130370AbRBAOjw>; Thu, 1 Feb 2001 09:39:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129336AbRBAOjm>; Thu, 1 Feb 2001 09:39:42 -0500
Received: from m2ep.pp.htv.fi ([212.90.64.98]:56850 "EHLO m2.pp.htv.fi")
	by vger.kernel.org with ESMTP id <S130370AbRBAOj3>;
	Thu, 1 Feb 2001 09:39:29 -0500
Date: Thu, 1 Feb 2001 16:38:48 +0200 (EET)
From: Timo Jantunen <jeti@iki.fi>
To: Andreas Dilger <adilger@turbolinux.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: kernel BUG at inode.c:889!
In-Reply-To: <200101311942.f0VJgSD23675@webber.adilger.net>
Message-ID: <Pine.LNX.4.30.0102011617190.781-100000@limbo.null.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jan 2001, Andreas Dilger wrote:

> Below is a patch which should fix this.  It _should_ prevent you from
> mounting this filesystem in the first place, and should also stop the BUG
> in inode.c.  I'm not 100% sure of correctness, however:

I tried to reproduce the BUG message, but I was unable to get to the same
situation again. (I tried to create several different RAID0 partitions,
format them to ext2 and tried mounting the partitions alone. I did get some
weird messages from partitions I did manage to mount (what you would expect
from mounting such partitions) but no more BUG messages.)

So unfortunately I can't help you to check if your fix works.


// /
....................................Timo Jantunen  ......................
       ZZZ      (Used to represent :Kuunsäde 8 A 28: Email: jeti@iki.fi :
the  sound of  a person  snoring.) :02210 Espoo    : http://iki.fi/jeti :
Webster's  Encyclopedic Unabridged :Finland        : GSM+358-40-5763131 :
Dictionary of the English Language :...............:....................:

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
