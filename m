Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130932AbRBXAbp>; Fri, 23 Feb 2001 19:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130939AbRBXAbf>; Fri, 23 Feb 2001 19:31:35 -0500
Received: from UX4.SP.CS.CMU.EDU ([128.2.198.104]:37722 "HELO
	ux4.sp.cs.cmu.edu") by vger.kernel.org with SMTP id <S130932AbRBXAbX>;
	Fri, 23 Feb 2001 19:31:23 -0500
Message-ID: <3A970055.1C6FD23A@cs.cmu.edu>
Date: Fri, 23 Feb 2001 19:29:09 -0500
From: Sourav Ghosh <sourav@cs.cmu.edu>
Organization: Carnegie Mellon University
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.15-timesys-u-16Jan01 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: jacob.blain.christen@entheal.com
CC: linux-kernel@vger.kernel.org
Subject: Re: creation of sock
In-Reply-To: <3A96C858.5C8FB714@cs.cmu.edu> <3A96E014.AFBD4859@entheal.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jacob L E Blain Christen wrote:

> looking further at
> net/ipv4/tcp_ipv4.c:tcp_create_openreq_child() (for 2.2.16)
> and
> net/ipv4/tcp_minisocks.c:tcp_create_openreq_child() (for 2.4.x)
>
> immediately after the sk_alloc() call (if it successful) it calls
>         memcpy(newsk, sk, sizeof(*newsk))
> i suggest setting your NULL initial values immediately after this line.
>
> sorry for the premature email

Didn't help.
The problem persists.

