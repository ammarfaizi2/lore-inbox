Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278423AbRJSPLh>; Fri, 19 Oct 2001 11:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278424AbRJSPL2>; Fri, 19 Oct 2001 11:11:28 -0400
Received: from [206.162.172.138] ([206.162.172.138]:63738 "EHLO
	remtk.solucorp.qc.ca") by vger.kernel.org with ESMTP
	id <S278423AbRJSPLI>; Fri, 19 Oct 2001 11:11:08 -0400
From: Jacques Gelinas <jack@solucorp.qc.ca>
Date: Fri, 19 Oct 2001 11:11:47 -0500
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Announce: many virtual servers on a single box (ipv6)
Cc: Riley Williams <rhw@memalpha.cx>
X-mailer: tlmpmail 0.1
Message-ID: <20011019111147.482a46f3e2d4@remtk.solucorp.qc.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Oct 2001 09:11:44 -0500, Riley Williams wrote
> Hi Jacques.

> > The concept is both very simple and sound
>
> ...
>
> > 	set_ipv4root to tie all processes in a vserver to one IP.
>
> How well does this work on an ipv6 only box?

For now, I guess it does not work. I have not tried it at all I must admit.
I suspect a tiny patch will work though. The set_ipv4root() syscall only handle
a u32 argument for now. It could be generalised I guess.


---------------------------------------------------------
Jacques Gelinas <jack@solucorp.qc.ca>
vserver: run general purpose virtual servers on one box, full speed!
http://www.solucorp.qc.ca/miscprj/s_context.hc
