Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263374AbTDLTAj (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 15:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263375AbTDLTAj (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 15:00:39 -0400
Received: from h-66-166-225-55.CMBRMAOR.covad.net ([66.166.225.55]:15918 "EHLO
	baradas.org") by vger.kernel.org with ESMTP id S263374AbTDLTAi (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 15:00:38 -0400
From: Peter Barada <peter@baradas.org>
To: dank@kegel.com
Cc: linux-kernel@vger.kernel.org, crossgcc@sources.redhat.com
In-reply-to: <3E983288.9000000@kegel.com> (message from Dan Kegel on Sat, 12
	Apr 2003 08:36:40 -0700)
Subject: Re: gcc-2.95 broken on PPC?
References: <3E983288.9000000@kegel.com>
Message-Id: <20030412191222.9654A98990@baradas.org>
Date: Sat, 12 Apr 2003 15:12:22 -0400 (EDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > The down side is that creating cross compilers from gcc 3.x is a lot
> > harder unless you already have a cross compiled glibc from gcc 2.95.x
> > in the proper paths.
>
>Yep.  I'm not looking forward to dealing with that.  Shame the gcc
>team keeps making building cross compilers harder.

It isn't that hard to build a cross compiler straight from the 3.x
sources; just takes an extra pass.  I've had pretty good luck building
m68k-linux and ppc-linux cross C/C++ compilers from the sources, all I
needed to do was to build a boostrap C compiler that is used to build
glibc, and then come back and build a full up C/C++ compiler.  Check
out the build script from Bill Gatliff's site:

<http://crossgcc.billgatliff.com/build-crossgcc.sh>

-- 
Peter Barada
peter@baradas.org
