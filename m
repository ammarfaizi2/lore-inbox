Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317978AbSGPUTl>; Tue, 16 Jul 2002 16:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317979AbSGPUTk>; Tue, 16 Jul 2002 16:19:40 -0400
Received: from msp-65-29-16-62.mn.rr.com ([65.29.16.62]:62849 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S317978AbSGPUTj>; Tue, 16 Jul 2002 16:19:39 -0400
Date: Tue, 16 Jul 2002 15:22:31 -0500
From: Shawn <core@enodev.com>
To: Mathieu Chouquet-Stringer <mathieu@newview.com>, Shawn <core@enodev.com>,
       linux-kernel@vger.kernel.org, Stelian Pop <stelian.pop@fr.alcove.com>,
       Gerhard Mack <gmack@innerfire.net>
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
Message-ID: <20020716152231.B6254@q.mn.rr.com>
References: <20020716124956.GK7955@tahoe.alcove-fr> <Pine.LNX.4.44.0207161107550.17919-100000@innerfire.net> <20020716153926.GR7955@tahoe.alcove-fr> <20020716194542.GD22053@merlin.emma.line.org> <20020716150422.A6254@q.mn.rr.com> <20020716161158.A461@shookay.newview.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020716161158.A461@shookay.newview.com>; from mathieu@newview.com on Tue, Jul 16, 2002 at 04:11:58PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In this case, can you use a RAID mirror or something, then break it?

Also, there's the LVM snapshot at the block layer someone already
mentioned, which when used with smaller partions is less overhead.
(less FS delta)

This problem isn't that complex.

On 07/16, Mathieu Chouquet-Stringer said something like:
> On Tue, Jul 16, 2002 at 03:04:22PM -0500, Shawn wrote:
> > You don't.
> > 
> > This is where you have a filesystem where syslog, xinetd, blogd,
> > bloatd-config-d2, raffle-ticketd DO NOT LIVE.
> > 
> > People forget so easily the wonders of multiple partitions.
> 
> I'm sorry, but I don't understand how it's going to change anything. For
> sure, it makes your life easier because you don't have to shutdown all your
> programs that have files opened in R/W mode. But in the end, you will have
> to shutdown something to remount the partition in R/O mode and usually you
> don't want or can't afford to do that.
> 
> -- 
> Mathieu Chouquet-Stringer              E-Mail : mathieu@newview.com
>     It is exactly because a man cannot do a thing that he is a
>                       proper judge of it.
>                       -- Oscar Wilde
--
Shawn Leas
core@enodev.com

I bought my brother some gift-wrap for Christmas. I took it to the Gift
Wrap department and told them to wrap it, but in a different print so he
would know when to stop unwrapping.
						-- Stephen Wright
