Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263659AbUJ3J3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263659AbUJ3J3F (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 05:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263660AbUJ3J3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 05:29:05 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:2573 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S263659AbUJ3J3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 05:29:02 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: Semaphore assembly-code bug
Date: Sat, 30 Oct 2004 12:28:42 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <417550FB.8020404@drdos.com.suse.lists.linux.kernel> <Pine.LNX.4.58.0410291133220.28839@ppc970.osdl.org.suse.lists.linux.kernel> <p73sm7xymvd.fsf@verdi.suse.de>
In-Reply-To: <p73sm7xymvd.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410301228.42561.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 30 October 2004 05:13, Andi Kleen wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > Anyway, it's quite likely that for several CPU's the fastest sequence ends 
> > up actually being 
> > 
> > 	movl 4(%esp),%ecx
> > 	movl 8(%esp),%edx
> > 	movl 12(%esp),%eax
> > 	addl $16,%esp
> > 
> > which is also one of the biggest alternatives.
> 
> For K8 it should be the fastest way. K7 probably too.

Pity. I always loved 1 byte insns :)

/me hopes that K8 rev E or K9 will have optimized pop.
--
vda

