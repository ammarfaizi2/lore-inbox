Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267337AbSLRTAj>; Wed, 18 Dec 2002 14:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267334AbSLRTAV>; Wed, 18 Dec 2002 14:00:21 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:18862 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267333AbSLRTAN>; Wed, 18 Dec 2002 14:00:13 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200212181908.gBIJ82M03155@devserv.devel.redhat.com>
Subject: Re: Freezing.. (was Re: Intel P6 vs P7 system call performance)
To: torvalds@transmeta.com (Linus Torvalds)
Date: Wed, 18 Dec 2002 14:08:02 -0500 (EST)
Cc: davej@codemonkey.org.uk (Dave Jones),
       vonbrand@inf.utfsm.cl (Horst von Brand), linux-kernel@vger.kernel.org,
       alan@redhat.com (Alan Cox), akpm@digeo.com (Andrew Morton)
In-Reply-To: <Pine.LNX.4.44.0212180936550.2891-100000@home.transmeta.com> from "Linus Torvalds" at Dec 18, 2002 09:41:15 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And I think it could work for the kernel too, especially the stable
> releases and for the process of getting there. I just don't really know
> how to set it up well.

A start might be

1.	Ack large patches you don't want with "Not for 2.6" instead
	of ignoring them. I'm bored of seeing the 18th resend of 
	this and that wildly bogus patch. 

	Then people know the status

2.	Apply patches only after they have been approved by the maintainer
	of that code area.

	Where it is core code run it past Andrew, Al and other people
	with extremely good taste.

3.	Anything which changes core stuff and needs new tools, setup
	etc please just say NO to for now. Modules was a mistake (hindsight
	I grant is a great thing), but its done. We don't want any more


4.	Violate 1-3 when appropriate as always, but preferably not to
	often and after consulting the good taste department 8)

Alan
