Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311475AbSCSRaL>; Tue, 19 Mar 2002 12:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311477AbSCSRaB>; Tue, 19 Mar 2002 12:30:01 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:10769 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S311475AbSCSR3o>;
	Tue, 19 Mar 2002 12:29:44 -0500
Date: Tue, 19 Mar 2002 10:30:22 -0700
From: yodaiken@fsmlabs.com
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        chiranjeevi vaka <cvaka_kernel@yahoo.com>,
        linux-kernel@vger.kernel.org
Subject: Re: using kmalloc
Message-ID: <20020319103022.A17491@hq.fsmlabs.com>
In-Reply-To: <20020319161831.80877.qmail@web21306.mail.yahoo.com> <20020319164136.GN20602@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2002 at 01:41:36PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Mar 19, 2002 at 08:18:31AM -0800, chiranjeevi vaka escreveu:
> 
> > I am getting some problems with kmalloc. If I tried to allocate more than
> > certain memory then the system is hanging while booting with the changed
> > kernel. Can you suggest me how to come out this situation. Can't I allocate
> > as much I want when I want to allocate in the kernel. 
> 
> try vmalloc, kmalloc is limited, AFAIK, to 128 KiB and even that is difficult
> to get after some time.

Apparently, kmalloc semantics changed at some point
so it does not ever return error.


-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

