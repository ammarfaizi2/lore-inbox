Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262678AbSI1BlS>; Fri, 27 Sep 2002 21:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262679AbSI1BlS>; Fri, 27 Sep 2002 21:41:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50952 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262678AbSI1BlR>;
	Fri, 27 Sep 2002 21:41:17 -0400
Date: Sat, 28 Sep 2002 02:46:34 +0100
From: Matthew Wilcox <willy@debian.org>
To: Thomas Molina <tmolina@cox.net>
Cc: linux-kernel@vger.kernel.org, Lukasz Trabinski <lukasz@wsisiz.edu.pl>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Jordan Breeding <jordan.breeding@attbi.com>,
       Matthew Wilcox <willy@debian.org>, Robert Love <rml@tech9.net>,
       Mikael Pettersson <mikpe@csd.uu.se>, Andrew Morton <akpm@digeo.com>
Subject: Re: 2.5 Kernel Problem Reports as of 27 Sep
Message-ID: <20020928024634.C18377@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.44.0209271833280.12092-100000@dad.molina>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0209271833280.12092-100000@dad.molina>; from tmolina@cox.net on Fri, Sep 27, 2002 at 07:54:16PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2002 at 07:54:16PM -0500, Thomas Molina wrote:
>   17. http://marc.theaimsgroup.com/?l=linux-kernel&m=103237662509801&w=2
>    oops in lock_get_status                open               18 Sep 2002
> 
>   18. http://marc.theaimsgroup.com/?l=linux-kernel&m=103244657605155&w=2
>                                           additional reports 20 Sep 2002
> 
> Matthew Wilcox <willy@debian.org> requested debugging data and was working 
> on a fix.  What is the status of this?

I've been able to reproduce it (with ntop).  I think I know which change
broke it.  What I haven't been able to do is write a testcase which
reliably provokes it.  Help appreciated.

-- 
Revolutions do not require corporate support.
