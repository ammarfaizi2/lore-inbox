Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262409AbUKDUGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262409AbUKDUGb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 15:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262393AbUKDUDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 15:03:04 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:36421 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262409AbUKDUCX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 15:02:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=t/vCpB9j1+yhJGIqag/3U2B8+WVXrCD1bGBT0Mq/d7s7YhdqOCkSjZqMeProuynh+TYqV5p6Y8ZIQQLM03zTvXpYfgxO8YT2zP4qcFHwptnO6RNLxXKrdh2T3fapRFr3CKGzhqEpDmHN4kYYzhZw0KDNcJWyzOM6AfftmYvjt4E=
Message-ID: <df47b87a041104120239dfa79d@mail.gmail.com>
Date: Thu, 4 Nov 2004 15:02:18 -0500
From: Ioan Ionita <opslynx@gmail.com>
Reply-To: Ioan Ionita <opslynx@gmail.com>
To: Ian Hastie <ianh@iahastie.clara.net>
Subject: Re: support of older compilers
Cc: valdis.kletnieks@vt.edu, Adam Heath <doogie@debian.org>,
       Chris Wedgwood <cw@f00f.org>, Christoph Hellwig <hch@infradead.org>,
       Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200411041936.27100.ianh@iahastie.local.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41894779.10706@techsource.com>
	 <Pine.LNX.4.58.0411041050040.1229@gradall.private.brainfood.com>
	 <200411041704.iA4H4sdZ014948@turing-police.cc.vt.edu>
	 <200411041936.27100.ianh@iahastie.local.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nobody mentioned that fact that newer versions of gcc, albeit slower
at compiling, do tend to generate binaries that have faster execution

On Thu, 4 Nov 2004 19:36:26 +0000, Ian Hastie <ianh@iahastie.clara.net> wrote:
> On Thursday 04 Nov 2004 17:04, Valdis.Kletnieks@vt.edu wrote:
> 
> 
> > On Thu, 04 Nov 2004 10:50:38 CST, Adam Heath said:
> > > I didn't deny the speed difference of older and newer compilers.
> > >
> > > But why is this an issue when compiling a kernel?  How often do you
> > > compile your kernel?
> >
> > If you're working on older hardware (note the number of people on this
> > list still using 500mz Pentium3 and similar), and a kernel developer, the
> > difference between 2 hours to build a kernel and 4 hours to build a
> > kernel matters quite a bit.
> 
> How often is it necessary to do a full rebuild of the kernel?  If the
> dependencies in the make system work properly then only the amended parts
> should be recompiled.  That'd be a much bigger time saving than just using an
> older compiler.
> 
> --
> Ian.
> 
> EOM
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
