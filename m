Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317355AbSIEJOT>; Thu, 5 Sep 2002 05:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317359AbSIEJOT>; Thu, 5 Sep 2002 05:14:19 -0400
Received: from holomorphy.com ([66.224.33.161]:9642 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317355AbSIEJOS>;
	Thu, 5 Sep 2002 05:14:18 -0400
Date: Thu, 5 Sep 2002 02:09:59 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: rusty@rustcorp.com.au, Linus Torvalds <torvalds@transmeta.com>,
       Andrew Morton <akpm@zip.com.au>, Dave Miller <davem@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Important per-cpu fix.
Message-ID: <20020905090959.GG888@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dipankar Sarma <dipankar@in.ibm.com>, rusty@rustcorp.com.au,
	Linus Torvalds <torvalds@transmeta.com>,
	Andrew Morton <akpm@zip.com.au>, Dave Miller <davem@redhat.com>,
	linux-kernel@vger.kernel.org
References: <20020905144023.A14040@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020905144023.A14040@in.ibm.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In article <20020904023535.73D922C12D@lists.samba.org> Rusty Russell wrote:
>> This might explain the wierd per-cpu problem reports from Andrew and
>> Dave, and also that nagging feeling that I'm an idiot...

On Thu, Sep 05, 2002 at 02:40:23PM +0530, Dipankar Sarma wrote:
> Not only does this fix the tasklet BUG with 2.5.32 but it also fixes a serial
> console hang with my 2.5.32 version of Ingo/Davem/Alexey's scalable timers 
> code that I have been debugging for the last two days. I use
> a per-cpu tasklet to run the timers, so it was probably killing me
> there.

Are you running on NUMA-Q? Do you also see the tty deadlock?


Thanks,
Bill
