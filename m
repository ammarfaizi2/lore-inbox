Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316798AbSFGHaJ>; Fri, 7 Jun 2002 03:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316819AbSFGHaH>; Fri, 7 Jun 2002 03:30:07 -0400
Received: from codepoet.org ([166.70.14.212]:7113 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S316798AbSFGHaG>;
	Fri, 7 Jun 2002 03:30:06 -0400
Date: Fri, 7 Jun 2002 01:26:37 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: [PATCH] initcall dependency solution.
Message-ID: <20020607072636.GA20454@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Rusty Russell <rusty@rustcorp.com.au>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, davem@redhat.com
In-Reply-To: <E17G94u-0000K4-00@wagner.rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk5, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Jun 07, 2002 at 12:02:11PM +1000, Rusty Russell wrote:
> This patch allows you to name initcall dependencies and subsystems.
> It is backward compatible with the current initcall levels, but
> doesn't respect link order: a couple of changes to make it boot, but
> more will be needed I expect.

Interesting.  So in theory this mechanism could also be used 
to speed booting by parallelizing execution of each independent
initcall dependancy tree...

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
