Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265939AbTBKEdn>; Mon, 10 Feb 2003 23:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266622AbTBKEdn>; Mon, 10 Feb 2003 23:33:43 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:51095 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S265939AbTBKEdm>; Mon, 10 Feb 2003 23:33:42 -0500
From: Ian Wienand <ianw@gelato.unsw.edu.au>
To: Dan Kegel <dkegel@ixiacom.com>
Date: Tue, 11 Feb 2003 15:43:19 +1100
Cc: linux-kernel@vger.kernel.org
Subject: Re: /proc/profile in 2.4 for ppc?
Message-ID: <20030211044319.GB23489@cse.unsw.edu.au>
References: <3E484EA8.4000104@ixiacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E484EA8.4000104@ixiacom.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2003 at 05:15:20PM -0800, Dan Kegel wrote:
> Anyone know offhand if the 2.4 kernel supports kernel profiling
> via /proc/profile for ppc?

I haven't tried it but it looks ok.  see arch/ppc/kernel/time.c
timer_interrupt() and ppc_do_profile().

boot with profile=2 as a kernel option and use 'readprofile', that
will tell you for sure.

-i
ianw@gelato.unsw.edu.au
http://www.gelato.unsw.edu.au
