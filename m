Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316969AbSFAAR1>; Fri, 31 May 2002 20:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316970AbSFAAR0>; Fri, 31 May 2002 20:17:26 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:5135 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S316969AbSFAARZ>; Fri, 31 May 2002 20:17:25 -0400
Date: Sat, 1 Jun 2002 01:17:23 +0100
From: John Levon <movement@marcelothewonderpenguin.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sys_sysinfo overhaul
Message-ID: <20020601001723.GB91199@compsoc.man.ac.uk>
In-Reply-To: <1022879767.958.194.camel@sinai>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Bendik Singers - Afrotid
X-Toppers: N/A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2002 at 02:16:07PM -0700, Robert Love wrote:

> 	- move sys_sysinfo to kernel/timer.c from kernel/info.c:
> 	  why one small syscall got its own file is beyond me.

Huh ? What on earth is wrong with that ? Including a load of crap
in timer.c just increases false dependencies.

On the contrary, I wish the kernel had more file-level barriers.

john
