Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932356AbWBBW2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbWBBW2s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 17:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWBBW2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 17:28:47 -0500
Received: from smtp.osdl.org ([65.172.181.4]:56223 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932356AbWBBW2r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 17:28:47 -0500
Date: Thu, 2 Feb 2006 14:29:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: rlrevell@joe-job.com, linux-kernel@vger.kernel.org
Subject: Re: Wanted: hotfixes for -mm kernels
Message-Id: <20060202142909.7335e0f0.akpm@osdl.org>
In-Reply-To: <200602021710_MC3-1-B771-3DDC@compuserve.com>
References: <200602021710_MC3-1-B771-3DDC@compuserve.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert <76306.1226@compuserve.com> wrote:
>
> E.g. in 2.6.16-rc1-mm4 we have:
> 
>         - SMP alternatives removes the lock prefix from instructions
>           in every loaded module because it wrongly believes you are
>           running an SMP kernel on UP.
> 
>         - Device-mapper mirroring is using the wrong endianness and will
>           try to recover non-existent regions on the device.
> 
>         - Compiler spews hundreds of warning messages during build.
> 
>         - VGA console scrollback is totally broken because it prints
>           a message on every scroll operation.

We suck.

> Patches for all of the above and more have been posted to the list and
> I have applied them.  All I want is a place to collect them so they can
> be more easily found.

OK, I'll create a hot-fixes directory there and will try to remember to put
stuff into it.
