Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288781AbSANSnN>; Mon, 14 Jan 2002 13:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288801AbSANSnD>; Mon, 14 Jan 2002 13:43:03 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:37385 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S288782AbSANSl6>;
	Mon, 14 Jan 2002 13:41:58 -0500
Date: Mon, 14 Jan 2002 11:39:10 -0700
From: yodaiken@fsmlabs.com
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: yodaiken@fsmlabs.com, Momchil Velikov <velco@fadata.bg>,
        Arjan van de Ven <arjan@fenrus.demon.nl>,
        Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020114113910.A24210@hq.fsmlabs.com>
In-Reply-To: <E16PZbb-0003i6-00@the-village.bc.nu> <87k7ukyjme.fsf@fadata.bg> <20020114030925.A1363@viejo.fsmlabs.com> <E16QC5P-0000nO-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <E16QC5P-0000nO-00@starship.berlin>; from phillips@bonn-fries.net on Mon, Jan 14, 2002 at 07:43:59PM +0100
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2002 at 07:43:59PM +0100, Daniel Phillips wrote:
> On January 14, 2002 10:09 am, yodaiken@fsmlabs.com wrote:
> > UNIX generally tries to ensure liveness. So you know that
> > 	cat lkarchive | grep feel | wc
> > will complete and not just that, it will run pretty reasonably because
> > for UNIX _every_ process is important and gets cpu and IO time.
> > When you start trying to add special low latency tasks, you endanger
> > liveness.  And preempt is especially corrosive because one of the 
> > mechanisms UNIX uses to assure liveness is to make sure that once a 
> > process starts it can do a significant chunk of work.
> 
> You're claiming that preemption by nature is not Unix-like?

Kernel preemption is not traditionally part of UNIX. 

> 
> --
> Daniel

-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

