Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbVKKUXX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbVKKUXX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 15:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbVKKUXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 15:23:23 -0500
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:29614 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751161AbVKKUXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 15:23:22 -0500
Date: Fri, 11 Nov 2005 14:23:17 -0600
From: Lee <linuxtwidler@gmail.com>
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: kernel crash debugging
Message-ID: <20051111142317.4e0421b7@localhost>
In-Reply-To: <4374FB9A.4020400@shaw.ca>
References: <56Z7S-85a-29@gated-at.bofh.it>
	<4374FB9A.4020400@shaw.ca>
Reply-To: linuxtwidler@gmail.com
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I am running kernel version '2.6.13-gentoo-r3'
> > 
> > My hardware is as follows:
> >  - motherboard:  Tyan Tiger 230T
> >  - processors: 2 Pentium II 1.13Ghz
> >  - memory: 1.5GB 
> > 
> > I have been having intermittent lockups for a while now.
> > 
> > At first, I thought it had something to do with vmware, but this is no occuring with a non-tainted kernel.
> 
> First thing I would try with those kind of faults is Memtest86, you 
> could have some bad RAM or bad memory timing settings..

I could understand that concept except for one thing:
  - with 4k stacks turned on, i have the lockups
  - with 4k stacks turned off, i have not had a single lock up at all.

Per an earlier email from 'pageexec@freemail.hu', it appears that there is still an execution path in the kernel with is causing a stack overflow.




-- 
Lee
linuxtwidler@gmail.com

 14:18:50 up 4 days, 19:29,  1 user,  load average: 2.80, 2.72, 2.30
