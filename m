Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135348AbRDLVhj>; Thu, 12 Apr 2001 17:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135350AbRDLVhV>; Thu, 12 Apr 2001 17:37:21 -0400
Received: from dystopia.lab43.org ([209.217.122.210]:57022 "EHLO
	dystopia.lab43.org") by vger.kernel.org with ESMTP
	id <S135349AbRDLVfp>; Thu, 12 Apr 2001 17:35:45 -0400
Date: Thu, 12 Apr 2001 17:33:52 -0400 (EDT)
From: Rod Stewart <stewart@dystopia.lab43.org>
To: Andrew Morton <andrewm@uow.edu.au>
cc: <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: 8139too: defunct threads
In-Reply-To: <3AD61E6A.10D6B654@uow.edu.au>
Message-ID: <Pine.LNX.4.33.0104121732420.32198-100000@dystopia.lab43.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 12 Apr 2001, Andrew Morton wrote:
> Rod Stewart wrote:
> >
> > On Thu, 12 Apr 2001, Andrew Morton wrote:
> > > Is there something unusual about your setup?
> >
> > One box is standard PIII with RH 7.0, the other is a custom Crusoe TM5400
> > board.  But from further investigation it appears to be a kernel config
> > option.  As I've got a 2.4.0 kernel which has very little compiled in and
> > not showing the problem and another kernel which has many more networking
> > options built in and showing the problem.  I've seen this problem
> > since 2.4.0.test11.
> >
>
> Sorry.  I meant: what is process 1 on this machine?  Is it not
> the normal init?  If not, then according to Alan, the fault
> lies with your userspace.  Kernel requires that PID 1 reap
> children.

Yes, it is the normal init on both boxes.

-Rms

