Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292605AbSBZEAg>; Mon, 25 Feb 2002 23:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292621AbSBZEA0>; Mon, 25 Feb 2002 23:00:26 -0500
Received: from zok.sgi.com ([204.94.215.101]:6354 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S292605AbSBZEAS>;
	Mon, 25 Feb 2002 23:00:18 -0500
Date: Mon, 25 Feb 2002 19:59:49 -0800
From: Paul Jackson <pj@engr.sgi.com>
To: Dipankar Sarma <dipankar@in.ibm.com>
cc: Rusty Russell <rusty@rustcorp.com.au>,
        Kimio Suganuma <k-suganuma@mvj.biglobe.ne.jp>, focht@ess.nec.de,
        rml@tech9.net, linux-kernel@vger.kernel.org, mingo@elte.hu,
        colpatch@us.ibm.com, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: [PATCH] O(1) scheduler set_cpus_allowed for
 non-current tasks
In-Reply-To: <20020225175853.B15397@in.ibm.com>
Message-ID: <Pine.SGI.4.21.0202251948150.592622-100000@sam.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Feb 2002, Dipankar Sarma wrote:
>
> If these are processes that are bound to the CPU to be shut down,
> wouldn't it make sense to fail the CPU shut down operation ? If you
> are giving enough control to the user to make CPU affinity decisions,
> they better know how to cleanup before shutting down a CPU.

I can imagine some users (applications) wanting to insist on
staying on a particular CPU (Pike's Peak or Bust), and some
content to be migrated automatically, and some wanting to
receive and act on requests to migrate.

One of these policies might be default, with others as options.

Some CPU shut down operations _can't_ fail ... if they are motivated
say by hardware about to fail.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373

