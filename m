Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262833AbUJ1Ivi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262833AbUJ1Ivi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 04:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262836AbUJ1Ivf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 04:51:35 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:26892 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262832AbUJ1Iuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 04:50:46 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Andi Kleen <ak@suse.de>, Sorav Bansal <sbansal@stanford.edu>
Subject: Re: BUG REPORT: User/Kernel Pointer bug in sys_poll
Date: Thu, 28 Oct 2004 11:50:32 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <20041028052218.52478.qmail@web50207.mail.yahoo.com.suse.lists.linux.kernel> <Pine.GSO.4.44.0410272246240.7124-100000@elaine9.Stanford.EDU.suse.lists.linux.kernel> <p73d5z31het.fsf@verdi.suse.de>
In-Reply-To: <p73d5z31het.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410281150.32412.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 October 2004 09:32, Andi Kleen wrote:
> Sorav Bansal <sbansal@stanford.edu> writes:
> 
> > Older x86 architectures (386 and before) allow the kernel to write to any
> > user location regardless of the write-protect bits.
> 
> Actually it's only some early steppings of 386 and Linux never ran on
> a 286 or earlier. I think the best would be to just ignore it, the affected
> user base is very likely zero or very near it. I suspect the 
> probability of one of these machines still used as a multiuser
> machine is very definitely nil.

People ran Linux on 8086 (DragonLinux,ELKS iirc).

I admire their level of madness, but, really,
it is not useful to spend time on such things.

My personal bottom line of supported hw is 486.
--
vda

