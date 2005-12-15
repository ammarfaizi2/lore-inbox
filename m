Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750908AbVLOSiy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908AbVLOSiy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 13:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbVLOSiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 13:38:54 -0500
Received: from nproxy.gmail.com ([64.233.182.202]:25214 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750907AbVLOSix convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 13:38:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lmoEfwo68ZCOxpaTZKVh/5qbUiTMXObcuR6JK/Z1TSIAEmiL553tyYaR7mvxsjsnKmiv+f7l0br4/nhmgnAbcMwhuzFtDnqd5lJIx8Enx9IprumRR+/ZvxeGANIPz+vbZOHVW5Xv1JUhBJw90wj0zv/UcXx685kdZGzLWLqqsm4=
Message-ID: <40f323d00512151038u6de89f5cp9720084d852c3f2c@mail.gmail.com>
Date: Thu, 15 Dec 2005 19:38:50 +0100
From: Benoit Boissinot <bboissin@gmail.com>
To: Martin Bligh <mbligh@mbligh.org>
Subject: Re: 2.6.15-rc5-mm3 (new build failure)
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <43A1B729.5040009@mbligh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43A1A95D.10800@mbligh.org>
	 <40f323d00512151009h5eece648w80882f0cda078507@mail.gmail.com>
	 <43A1B729.5040009@mbligh.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/05, Martin Bligh <mbligh@mbligh.org> wrote:
> Benoit Boissinot wrote:
> > On 12/15/05, Martin Bligh <mbligh@mbligh.org> wrote:
> >
> >>New build failure since -mm2:
> >>Config is
> >>http://ftp.kernel.org/pub/linux/kernel/people/mbligh/config/abat/elm3b67
> >>
> >>I'm guessing it was using gcc 2.95.4, though not sure.
> >>
> >>   CC      arch/i386/kernel/asm-offsets.s
> >>In file included from include/linux/stddef.h:4,
> >>                  from include/linux/posix_types.h:4,
> >>                  from include/linux/types.h:13,
> >>                  from include/linux/capability.h:16,
> >>                  from include/linux/sched.h:7,
> >>                  from arch/i386/kernel/asm-offsets.c:7:
> >>include/linux/compiler.h:46: #error Sorry, your compiler is too old/not
> >>recognized.
> >
> >
> > support for gcc-2.95 was dropped in -mm3.
>
> Pah. For any good reason? or just people being lazy?
> It's worked fine for about 5 years. Difficult to beleive it's suddenly
> unworkable.
>

There is an article on kerneltrap: http://kerneltrap.org/node/5974

regards,

Benoit
