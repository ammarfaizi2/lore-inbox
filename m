Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133070AbREIVXh>; Wed, 9 May 2001 17:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135276AbREIVX2>; Wed, 9 May 2001 17:23:28 -0400
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:11595 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S133070AbREIVXO>; Wed, 9 May 2001 17:23:14 -0400
Message-Id: <200105092125.f49LPew13300@jen.americas.sgi.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: martin@bugs.unl.edu.ar (=?iso-8859-1?q?Mart=EDn=20Marqu=E9s?=),
        linux-kernel@vger.kernel.org
Subject: Re: reiserfs, xfs, ext2, ext3 
In-Reply-To: Message from Alan Cox <alan@lxorguk.ukuu.org.uk> 
   of "Wed, 09 May 2001 15:49:17 BST." <E14xVHE-0002VB-00@the-village.bc.nu> 
Date: Wed, 09 May 2001 16:25:40 -0500
From: Steve Lord <lord@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> XFS is very fast most of the time (deleting a file is sooooo slow its like us
> ing
> old BSD systems). Im not familiar enough with its behaviour under Linux yet.

Hmm, I just removed 2.2 Gbytes of data in 30000 files in 37 seconds (14.4
seconds system time), not tooo slow. And that is on a pretty vanilla 2 cpu
linux box with a not very exciting scsi drive.

> 
> What you might want to do is to make a partition for 'mystery journalling fs'
> and benchmark a bit.
> 
> Alan
> 

I agree with Alan here, the only sure fire way to find out which filesystem
will work best for your application is to try it out. I have found reiserfs
to be very fast in some tests, especially those operating on lots of small
files, but contrary to some peoples, belief XFS is good for a lot more than
just messing with Gbyte long data files.

Steve Lord


