Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265633AbUABUH7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 15:07:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265636AbUABUH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 15:07:59 -0500
Received: from intra.cyclades.com ([64.186.161.6]:46722 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S265633AbUABUH6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 15:07:58 -0500
Date: Fri, 2 Jan 2004 18:07:00 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Stan Bubrouski <stan@ccs.neu.edu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, khorben@defora.org
Subject: Re: [Fwd: Linux on Cyrix 6x86]
In-Reply-To: <1072812026.1760.19.camel@duergar>
Message-ID: <Pine.LNX.4.58L.0401021806090.20333@logos.cnet>
References: <3FF1C5BC.8010902@zytor.com> <1072812026.1760.19.camel@duergar>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 30 Dec 2003, Stan Bubrouski wrote:

> On Tue, 2003-12-30 at 13:36, H. Peter Anvin wrote:
> > From: Pierre Pronchery <khorben@defora.org>
> > To: hpa@zytor.com
> > Subject: Linux on Cyrix 6x86
> > Date: Tue, 30 Dec 2003 15:19:18 +0100
> >
> > 	Hi,
> >
> > I've just compiled Linux 2.4.23 for a Cyrix 6x86 P166+ processor, with
> > the appropriate "Processor family" option "586/K5/5x86/6x86/6x86MX"
> > (CONFIG_M586=y). It says it's for 586-compatible processors, possibly
> > lacking the TSC register, though the kernel panic'd at boot, saying it
> > needed a TSC register.
> >
>
> I have the same processor in my old archive machine with an ancient
> 2.0.36 kernel.  I do recall the kernel is an i586 and I believe there
> was a cyrix CPU option back then (I have to take the drives out of that
> machine and put them in this one to check as the system stopped booting
> a few days ago).  So looks like a bug.

Pierre informed me privately that he was doing something wrong --- he
managed to boot 2.4.23 with CONFIG_M586 on his Cyrix processor.
