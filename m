Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289995AbSAPQhC>; Wed, 16 Jan 2002 11:37:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289999AbSAPQgw>; Wed, 16 Jan 2002 11:36:52 -0500
Received: from [66.89.142.2] ([66.89.142.2]:9275 "EHLO starship.berlin")
	by vger.kernel.org with ESMTP id <S289995AbSAPQgk>;
	Wed, 16 Jan 2002 11:36:40 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Date: Wed, 16 Jan 2002 17:37:05 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.96.1020116102256.28369C-100000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1020116102256.28369C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16Qt3i-00020l-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 16, 2002 04:27 pm, Bill Davidsen wrote:
> On Tue, 15 Jan 2002, Daniel Phillips wrote:
> > On January 15, 2002 06:26 am, Mark Hahn wrote:
> > > > than the task's float, the completion time of the schedule as a whole will be 
> > > > delayed.  This is no different for a computer than it is for a group of 
> > > > people, it is still a scheduling problem.  Delaying any random task risks 
> > > 
> > > it is quite different.  with computers, there are often STRONG benefits
> > > to clustering, batching, chunking, piggybacking, whatever you want to call it.
> > 
> > It's no different.
> 
> Sorry, there are strong benefits from all of the things mentioned. I lack
> time and inclination to explain how caching works, but there are costs of
> changing from one thing to another.

With people, there are often STRONG benefits to clustering, batching, 
chunking, piggybacking.  See what I mean?

> The other issue is that processes doing i/o (blocking before a whole
> timeslice) will run better if they get priority when they can use the CPU.
> Therefore a system needs to recognize (and be tuned) for both of these.
> 
> Computers are very different than people in lines.

Oh yes, computers don't *know* they are in lines.

--
Daniel
