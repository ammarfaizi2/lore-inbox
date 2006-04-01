Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbWDAGEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbWDAGEv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 01:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbWDAGEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 01:04:51 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:1042 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932121AbWDAGEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 01:04:50 -0500
Date: Sat, 1 Apr 2006 08:04:33 +0200
From: Willy Tarreau <willy@w.ods.org>
To: George P Nychis <gnychis@cmu.edu>
Cc: Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: cannot get clean 2.4.20 kernel to compile
Message-ID: <20060401060433.GK21493@w.ods.org>
References: <5W8lY-1wF-29@gated-at.bofh.it> <442C81BC.7030605@shaw.ca> <60485.128.237.233.65.1143825987.squirrel@128.237.233.65>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60485.128.237.233.65.1143825987.squirrel@128.237.233.65>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2006 at 12:26:27PM -0500, George P Nychis wrote:
> I see...
> 
> here is my gcc version:
> gcc version 3.3.6 (Gentoo 3.3.6, ssp-3.3.6-1.0, pie-8.7.8)
> 
> Is it too new?

I think so. Either try with 2.95 or upgrade your kernel to 2.4.32.

Cheers,
Willy

> 
> Thanks!
> George
> 
> 
> > George P Nychis wrote:
> >> Hi,
> >> 
> >> I have downloaded the 2.4.20 kernel from ftp.kernel.org, have checked
> >> its sign, and no matter what I try I cannot get it to compile.
> >> 
> >> I do a make mrproper, I then do make dep which is fine, but then i try
> >> "make bzImage modules modules_install", selecting all the defaults, and
> >> get an SMP header error: http://rafb.net/paste/results/QzIq7v86.html
> >> 
> >> I then disable SMP support and get: 
> >> http://rafb.net/paste/results/muYA9t12.html
> >> 
> >> I even tried using my config from the 2.4.32 kernel which works
> >> perfectly fine, and I also get the sched errors.
> > 
> > What gcc version? Some old kernels might not be buildable with newer 
> > compilers.
> > 
> > -- Robert Hancock      Saskatoon, SK, Canada To email, remove "nospam" from
> > hancockr@nospamshaw.ca Home Page: http://www.roberthancock.com/
> > 
> > 
> > 
> 
> 
> -- 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
