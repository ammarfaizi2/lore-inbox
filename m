Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313057AbSC0R0f>; Wed, 27 Mar 2002 12:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313053AbSC0R0Z>; Wed, 27 Mar 2002 12:26:25 -0500
Received: from ccs.covici.com ([209.249.181.196]:11136 "EHLO ccs.covici.com")
	by vger.kernel.org with ESMTP id <S313057AbSC0R0O>;
	Wed, 27 Mar 2002 12:26:14 -0500
Date: Wed, 27 Mar 2002 12:26:08 -0500 (EST)
From: John Covici <covici@ccs.covici.com>
To: Bob Miller <rem@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.7 process accounting bombs out
In-Reply-To: <20020327074043.A2280@doc.pdx.osdl.net>
Message-ID: <Pine.LNX.4.40.0203271225340.747-100000@ccs.covici.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks much, that did it.


On Wed, 27 Mar 2002, Bob Miller wrote:

> On Wed, Mar 27, 2002 at 01:50:35AM -0500, John Covici wrote:
> > Whenever I try to start the init script for process accounting I get
> > the following error:
> >
> > Mar 27 00:02:02 ccs kernel: kernel BUG at acct.c:169!
> > Mar 27 00:02:02 ccs kernel: invalid operand: 0000
> > Mar 27 00:02:02 ccs kernel: CPU:    0
> > Mar 27 00:02:02 ccs kernel: EIP:    0010:[acct_file_reopen+8/208]
> > Not tainted
> > Mar 27 00:02:02 ccs kernel: EFLAGS: 00010246
> >
> > The system doesn't go down, but is there any way to fix this?
> >
> > Thanks.
> >
> > --
> >          John Covici
> >          covici@ccs.covici.com
>
> Apply the patch below.
>
>

-- 
         John Covici
         covici@ccs.covici.com

