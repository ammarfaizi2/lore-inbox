Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317992AbSGPUZx>; Tue, 16 Jul 2002 16:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317993AbSGPUZw>; Tue, 16 Jul 2002 16:25:52 -0400
Received: from esteel10.client.dti.net ([209.73.14.10]:33182 "EHLO
	shookay.newview.com") by vger.kernel.org with ESMTP
	id <S317992AbSGPUZv>; Tue, 16 Jul 2002 16:25:51 -0400
Date: Tue, 16 Jul 2002 16:27:34 -0400
From: Mathieu Chouquet-Stringer <mathieu@newview.com>
To: Shawn <core@enodev.com>
Cc: linux-kernel@vger.kernel.org, Stelian Pop <stelian.pop@fr.alcove.com>,
       Gerhard Mack <gmack@innerfire.net>
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
Message-ID: <20020716162733.A603@shookay.newview.com>
Mail-Followup-To: Mathieu Chouquet-Stringer <mathieu@newview.com>,
	Shawn <core@enodev.com>, linux-kernel@vger.kernel.org,
	Stelian Pop <stelian.pop@fr.alcove.com>,
	Gerhard Mack <gmack@innerfire.net>
References: <20020716124956.GK7955@tahoe.alcove-fr> <Pine.LNX.4.44.0207161107550.17919-100000@innerfire.net> <20020716153926.GR7955@tahoe.alcove-fr> <20020716194542.GD22053@merlin.emma.line.org> <20020716150422.A6254@q.mn.rr.com> <20020716161158.A461@shookay.newview.com> <20020716152231.B6254@q.mn.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020716152231.B6254@q.mn.rr.com>; from core@enodev.com on Tue, Jul 16, 2002 at 03:22:31PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2002 at 03:22:31PM -0500, Shawn wrote:
> In this case, can you use a RAID mirror or something, then break it?
> 
> Also, there's the LVM snapshot at the block layer someone already
> mentioned, which when used with smaller partions is less overhead.
> (less FS delta)
> 
> This problem isn't that complex.

I agree but I guess that if Matthias asked the question that way, he
probably meant he doesn't have a raid mirror or "something" (as you
say)... If you didn't plan your install (meaning you don't have the nice
raid or anything else), you're basically screwed...

-- 
Mathieu Chouquet-Stringer              E-Mail : mathieu@newview.com
    It is exactly because a man cannot do a thing that he is a
                      proper judge of it.
                      -- Oscar Wilde
