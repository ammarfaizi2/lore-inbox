Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262728AbUBZIJL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 03:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbUBZIJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 03:09:11 -0500
Received: from warden3-p.diginsite.com ([208.147.64.186]:436 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id S262728AbUBZIJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 03:09:06 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Jaco Kroon <jkroon@cs.up.ac.za>
Cc: Adrian Bunk <bunk@fs.tum.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Thu, 26 Feb 2004 00:08:59 -0800 (PST)
Subject: Re: 2.6.3 adaptec I2O will not compile
In-Reply-To: <403DA7FC.1060507@cs.up.ac.za>
Message-ID: <Pine.LNX.4.58.0402260007460.994@dlang.diginsite.com>
References: <403DA7FC.1060507@cs.up.ac.za>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-ID: <Pine.LNX.4.58.0402260007462.994@dlang.diginsite.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I received a post from Mark Salyzyn with a new driver that does compile,
he said that he has submitted the patches (I didn't get a chance to try
the new kernel yet, I expect to do that shortly and will report any
problems)

David Lang

 On Thu, 26 Feb 2004, Jaco
Kroon wrote:

> Date: Thu, 26 Feb 2004 00:02:04 -0800
> From: Jaco Kroon <jkroon@cs.up.ac.za>
> To: Adrian Bunk <bunk@fs.tum.de>
> Cc: David Lang <david.lang@digitalinsight.com>,
>      Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> Subject: Re: 2.6.3 adaptec I2O will not compile
>
>
> Adrian Bunk wrote:
>
> >On Fri, Feb 20, 2004 at 01:52:24PM -0800, David Lang wrote:
> >
> >
> >>when attempting to compile in support for the adaptec 2100/3100 series
> >>Raid card I get the following errors. I have attached my config
> >>
> >>
> >>
> >
> >
> I am currently working on this, so far I've managed to sort out the irq
> problems and only have some dma stuff that does not compile.  I don't
> think I'm going to bother getting it to compile though and rather
> directly convert to the new DMA-mapping stuff.  If anyone has any
> pointers and tips and pitfalls I need to look out for, please don't
> hessitate to mail me (It will be greatly appreciated).
>
> Jaco
> --
> Once I finally figured out all of life's answers, they changed the
> questions.
> ===========================================
> This message and attachments are subject to a disclaimer. Please refer
> to www.it.up.ac.za/documentation/governance/disclaimer/ for full
> details.
> Hierdie boodskap en aanhangsels is aan 'n vrywaringsklousule onderhewig.
> Volledige besonderhede is by
> www.it.up.ac.za/documentation/governance/disclaimer/ beskikbaar.
> ===========================================
>
>

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
