Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262543AbSI0Sdq>; Fri, 27 Sep 2002 14:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262532AbSI0Sdp>; Fri, 27 Sep 2002 14:33:45 -0400
Received: from [216.40.201.6] ([216.40.201.6]:22789 "EHLO
	www.businesssite.com.br") by vger.kernel.org with ESMTP
	id <S262531AbSI0Sdm>; Fri, 27 Sep 2002 14:33:42 -0400
Date: Fri, 27 Sep 2002 15:33:41 -0300
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: laredo@gnu.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] stradis fixes
Message-ID: <20020927183341.GA416@cathedrallabs.org>
References: <20020927172230.GQ20649@cathedrallabs.org> <1033149332.16726.3.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1033149332.16726.3.camel@irongate.swansea.linux.org.uk>
From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 2002-09-27 at 18:22, Aristeu Sergio Rozanski Filho wrote:
> > hi,
> > 	this patch makes stradis driver uses struct file_operations (struct
> > video_device changed).
> > 
> 
> What are all the (void *) casts you added supposed to be for ?
stradis.c: In function `saa_ioctl':
stradis.c:1340: warning: passing arg 1 of `__constant_copy_to_user' makes
pointer from integer without a cast
stradis.c:1340: warning: passing arg 1 of `__generic_copy_to_user' makes
pointer from integer without a cast
(snip)
am I missing something?

-- 
aris
