Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267023AbTCECVL>; Tue, 4 Mar 2003 21:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267029AbTCECVK>; Tue, 4 Mar 2003 21:21:10 -0500
Received: from packet.digeo.com ([12.110.80.53]:50351 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267023AbTCECVK>;
	Tue, 4 Mar 2003 21:21:10 -0500
Date: Tue, 4 Mar 2003 18:32:08 -0800
From: Andrew Morton <akpm@digeo.com>
To: Robert Love <rml@tech9.net>
Cc: cw@f00f.org, degger@fhm.edu, linux-kernel@vger.kernel.org
Subject: Re: Kernel bloat 2.4 vs. 2.5
Message-Id: <20030304183208.61b8ed2d.akpm@digeo.com>
In-Reply-To: <1046830980.999.78.camel@phantasy.awol.org>
References: <1046817738.4754.33.camel@sonja>
	<20030304154105.7a2db7fa.akpm@digeo.com>
	<20030305015957.GA27985@f00f.org>
	<1046830980.999.78.camel@phantasy.awol.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Mar 2003 02:31:33.0668 (UTC) FILETIME=[56711E40:01C2E2BF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love <rml@tech9.net> wrote:
>
> On Tue, 2003-03-04 at 20:59, Chris Wedgwood wrote:
> 
> > I can't see it helping *that* much, for me I have:
> > 
> >     charon:~/wk/linux% size 2.4.x-cw/vmlinux bk-2.5.x/vmlinux
> >        text    data     bss     dec     hex filename
> >     2003887  120260  191657 2315804  23561c 2.4.x-cw/vmlinux
> >     2411323  267551  181004 2859878  2ba366 bk-2.5.x/vmlinux
> > 
> >     gcc version 2.95.4 20011002 (Debian prerelease)
> 
> Ugh look at that increase in data.  Is this SMP?
> 

well kallsyms is worth 150k.

Do `strings vmlinux' and take a look at it all.
