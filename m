Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289328AbSCCWON>; Sun, 3 Mar 2002 17:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289306AbSCCWOD>; Sun, 3 Mar 2002 17:14:03 -0500
Received: from zok.SGI.COM ([204.94.215.101]:1751 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S289272AbSCCWNw>;
	Sun, 3 Mar 2002 17:13:52 -0500
Date: Sun, 3 Mar 2002 14:13:45 -0800
From: Paul Jackson <pj@engr.sgi.com>
To: Hubertus Franke <frankeh@watson.ibm.com>
cc: Martin Wirth <martin.wirth@dlr.de>, rusty@rustycorp.com.au,
        linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: [PATCH] Lightweight userspace semaphores...
In-Reply-To: <20020302090856.A1332@elinux01.watson.ibm.com>
Message-ID: <Pine.SGI.4.21.0203031410310.623951-100000@sam.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Mar 2002, Hubertus Franke wrote:
> But more conceptually, if you process dies while holding a lock ... 
> your app is toast at that point.

Without application specific knowledge, certainly.

Is there someway one could support a hook, to enable
an application to register a handler that could clean
up, for those apps that found that worthwhile?

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373

