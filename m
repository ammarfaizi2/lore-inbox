Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317971AbSGPUKc>; Tue, 16 Jul 2002 16:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317974AbSGPUKb>; Tue, 16 Jul 2002 16:10:31 -0400
Received: from esteel10.client.dti.net ([209.73.14.10]:16284 "EHLO
	shookay.newview.com") by vger.kernel.org with ESMTP
	id <S317973AbSGPUK3>; Tue, 16 Jul 2002 16:10:29 -0400
Date: Tue, 16 Jul 2002 16:11:58 -0400
From: Mathieu Chouquet-Stringer <mathieu@newview.com>
To: Shawn <core@enodev.com>
Cc: linux-kernel@vger.kernel.org, Stelian Pop <stelian.pop@fr.alcove.com>,
       Gerhard Mack <gmack@innerfire.net>
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
Message-ID: <20020716161158.A461@shookay.newview.com>
Mail-Followup-To: Mathieu Chouquet-Stringer <mathieu@newview.com>,
	Shawn <core@enodev.com>, linux-kernel@vger.kernel.org,
	Stelian Pop <stelian.pop@fr.alcove.com>,
	Gerhard Mack <gmack@innerfire.net>
References: <20020716124956.GK7955@tahoe.alcove-fr> <Pine.LNX.4.44.0207161107550.17919-100000@innerfire.net> <20020716153926.GR7955@tahoe.alcove-fr> <20020716194542.GD22053@merlin.emma.line.org> <20020716150422.A6254@q.mn.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020716150422.A6254@q.mn.rr.com>; from core@enodev.com on Tue, Jul 16, 2002 at 03:04:22PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2002 at 03:04:22PM -0500, Shawn wrote:
> You don't.
> 
> This is where you have a filesystem where syslog, xinetd, blogd,
> bloatd-config-d2, raffle-ticketd DO NOT LIVE.
> 
> People forget so easily the wonders of multiple partitions.

I'm sorry, but I don't understand how it's going to change anything. For
sure, it makes your life easier because you don't have to shutdown all your
programs that have files opened in R/W mode. But in the end, you will have
to shutdown something to remount the partition in R/O mode and usually you
don't want or can't afford to do that.

-- 
Mathieu Chouquet-Stringer              E-Mail : mathieu@newview.com
    It is exactly because a man cannot do a thing that he is a
                      proper judge of it.
                      -- Oscar Wilde
