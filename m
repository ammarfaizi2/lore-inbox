Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264939AbTBGOBt>; Fri, 7 Feb 2003 09:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265102AbTBGOBt>; Fri, 7 Feb 2003 09:01:49 -0500
Received: from crack.them.org ([65.125.64.184]:47853 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S264939AbTBGOBs>;
	Fri, 7 Feb 2003 09:01:48 -0500
Date: Fri, 7 Feb 2003 09:11:15 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.5.59-mm9
Message-ID: <20030207141114.GA31151@nevyn.them.org>
Mail-Followup-To: Andrew Morton <akpm@digeo.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Ingo Molnar <mingo@elte.hu>
References: <20030207013921.0594df03.akpm@digeo.com> <20030207030350.728b4618.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030207030350.728b4618.akpm@digeo.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2003 at 03:03:50AM -0800, Andrew Morton wrote:
> Andrew Morton <akpm@digeo.com> wrote:
> >
> > http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.59/2.5.59-mm9/
> 
> I've taken this down.
> 
> Ingo, there's something bad in the signal changes in Linus's current tree.
> 
> mozilla won't display, and is unkillable:

Yeah, I'm seeing hangs in rt_sigsuspend under GDB also.  Thanks for
saying that they show up without ptrace; I hadn't been able to
reproduce them without it.

Something is causing realtime signals to drop.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
