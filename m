Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280715AbRKGBCu>; Tue, 6 Nov 2001 20:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280727AbRKGBCa>; Tue, 6 Nov 2001 20:02:30 -0500
Received: from firebird.planetinternet.be ([195.95.34.5]:20753 "EHLO
	firebird.planetinternet.be") by vger.kernel.org with ESMTP
	id <S280715AbRKGBC0>; Tue, 6 Nov 2001 20:02:26 -0500
Date: Wed, 7 Nov 2001 02:01:37 +0100
From: Kurt Roeckx <Q@ping.be>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: Riley Williams <rhw@MemAlpha.cx>, Pavel Machek <pavel@suse.cz>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: Linux updates RTC secretly when clock synchronizes
Message-ID: <20011107020137.A1887@ping.be>
In-Reply-To: <Pine.LNX.4.21.0111062347080.16087-100000@Consulate.UFP.CX> <812671195.1005093860@[195.224.237.69]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <812671195.1005093860@[195.224.237.69]>; from linux-kernel@alex.org.uk on Wed, Nov 07, 2001 at 12:44:21AM -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2001 at 12:44:21AM -0000, Alex Bligh - linux-kernel wrote:
> 
> 
> --On Wednesday, 07 November, 2001 12:00 AM +0000 Riley Williams 
> <rhw@MemAlpha.cx> wrote:
> 
> >  2. The kernel makes no internal reference to the /dev/rtc driver,
> >     and it is left to userland tools to sync to the RTC on boot,
> >     and at other times as required.
> 
> I think the kernel should set the machine time to the RTC time
> as an initializer on boot. Other than that, I agree.

Which is something you do from userspace.


Kurt

