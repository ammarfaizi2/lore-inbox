Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287487AbSANQVR>; Mon, 14 Jan 2002 11:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287612AbSANQU7>; Mon, 14 Jan 2002 11:20:59 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:6151 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S287487AbSANQUv>;
	Mon, 14 Jan 2002 11:20:51 -0500
Date: Mon, 14 Jan 2002 09:18:01 -0700
From: yodaiken@fsmlabs.com
To: Roman Zippel <zippel@linux-m68k.org>
Cc: yodaiken@fsmlabs.com, Momchil Velikov <velco@fadata.bg>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Arjan van de Ven <arjan@fenrus.demon.nl>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020114091801.A23139@hq.fsmlabs.com>
In-Reply-To: <20020114064548.D22065@hq.fsmlabs.com> <Pine.LNX.4.33.0201141541140.29505-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.33.0201141541140.29505-100000@serv>; from zippel@linux-m68k.org on Mon, Jan 14, 2002 at 03:56:05PM +0100
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2002 at 03:56:05PM +0100, Roman Zippel wrote:
> Hi,
> 
> On Mon, 14 Jan 2002 yodaiken@fsmlabs.com wrote:
> 
> > is going to be an enormously important issue.  However, once you add SCHED_FIFO in the
> > current scheme, this becomes more complex. And with preempt, you cannot even offer the
> > assurance that once a process gets the cpu it will make _any_ advance at all.
> 
> I'm not sure if I understand you correctly, but how is this related to
> preempt?

It's pretty subtle. If there is no preempt, processes don't get preempted.
If there is preempt, they can be preempted. Amazing isn't it? 
