Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261631AbVGETvh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbVGETvh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 15:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbVGETvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 15:51:37 -0400
Received: from urchin.mweb.co.za ([196.2.24.26]:39549 "EHLO urchin.mweb.co.za")
	by vger.kernel.org with ESMTP id S261658AbVGETve (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 15:51:34 -0400
From: Bongani Hlope <bonganilinux@mweb.co.za>
To: Sven Rudolph <rudsve@drewag.de>
Subject: Re: Tracking a bug in x86-64
Date: Tue, 5 Jul 2005 21:52:23 +0200
User-Agent: KMail/1.8.50
Cc: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Juan Gallego <Little.Boss@physics.mcgill.ca>
References: <200506132259.22151.bonganilinux@mweb.co.za> <200506160139.04389.bonganilinux@mweb.co.za> <xfkll4lfy41.fsf@uxkm53.drewag.de>
In-Reply-To: <xfkll4lfy41.fsf@uxkm53.drewag.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507052152.24022.bonganilinux@mweb.co.za>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 July 2005 10:36 am, Sven Rudolph wrote:
> Bongani Hlope <bonganilinux@mweb.co.za> writes:
> 

8<

> > Hi Linus
> >
> > I just tested, 2.6.12-rc6 minus randomisation-top-of-stack-randomization.patch Works For Me (tm)
> 
> Sorry, I didn't follow the original discussion: Is this problem
> expected to be solved in 2.6.12.2? Is it solved for you?
> 
> (I get similiar problems in 2.6.12.2, and I am uns ure know how to
> proceed.)
> 
> 	Sven

Hi Sven

I haven't tested 2.6.12.2 but the problem was introduced around 2.6.11-mm1 and
found its way to 2.6.12-rcX. First try to run the following command (this works for me)
echo 0 > /proc/sys/kernel/randomize_va_space
I got an email from Juan Gallego (cc'd), he says that command does not work for him though.

Andrew,
Should I log this on the kernel's bugzilla?

Regards
/etc/sysctl.conf
