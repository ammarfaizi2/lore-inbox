Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263956AbTJ1Mmi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 07:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263959AbTJ1Mmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 07:42:38 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:15316 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id S263956AbTJ1Mmh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 07:42:37 -0500
Date: Tue, 28 Oct 2003 23:39:49 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Pavel Machek <pavel@suse.cz>
Cc: pavel@suse.cz, felipe_alfaro@linuxmail.org, mochel@osdl.org,
       george@mvista.com, johnstul@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [pm] fix time after suspend-to-*
Message-Id: <20031028233949.770059b0.sfr@canb.auug.org.au>
In-Reply-To: <20031028122907.GA1940@elf.ucw.cz>
References: <Pine.LNX.4.44.0310271535160.13116-100000@cherise>
	<1067329994.861.3.camel@teapot.felipe-alfaro.com>
	<20031028093233.GA1253@elf.ucw.cz>
	<20031028224101.3220e0a6.sfr@canb.auug.org.au>
	<20031028122907.GA1940@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Oct 2003 13:29:07 +0100 Pavel Machek <pavel@suse.cz> wrote:
>
> Is adding signal really that easy? I thought there's limited number of
> them...

64.  However, we would need to coordinate with the libc folks ...
and it may not be actually possible if people are using hard coded
signals at the start of the real time range ...

So probably much more pain than its worth.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
