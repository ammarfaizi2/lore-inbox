Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262806AbSLaJPb>; Tue, 31 Dec 2002 04:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262807AbSLaJPb>; Tue, 31 Dec 2002 04:15:31 -0500
Received: from boden.synopsys.com ([204.176.20.19]:52637 "HELO
	boden.synopsys.com") by vger.kernel.org with SMTP
	id <S262806AbSLaJP3>; Tue, 31 Dec 2002 04:15:29 -0500
Date: Tue, 31 Dec 2002 10:23:42 +0100
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: Gianni Tedesco <gianni@ecsc.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: trivial sys_mincore cleanup
Message-ID: <20021231092342.GB26221@riesen-pc.gr05.synopsys.com>
Reply-To: alexander.riesen@synopsys.COM
References: <1040383074.12106.30.camel@lemsip>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1040383074.12106.30.camel@lemsip>
User-Agent: Mutt/1.4i
Organization: Synopsys, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gianni Tedesco, Fri, Dec 20, 2002 12:17:54 +0100:
> Patch makes 2 simple cleanups:
>  - Checks the syscall parameters before grabbing mmap semaphore.
>  - Tidy up a comment.

The comment is actually right: it is an old mathematical notation
to describe regions - from start until end, but not including the end.

>         /*
> -        * If the interval [start,end) covers some unmapped address
> +        * If the interval [start,end] covers some unmapped address
>          * ranges, just ignore them, but return -ENOMEM at the end.
>          */

-alex

