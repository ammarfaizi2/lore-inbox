Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266639AbUAWSr7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 13:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266640AbUAWSr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 13:47:59 -0500
Received: from nevyn.them.org ([66.93.172.17]:8619 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S266639AbUAWSr5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 13:47:57 -0500
Date: Fri, 23 Jan 2004 13:47:55 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Mariusz Mazur <mmazur@kernel.pl>
Cc: linux-kernel@vger.kernel.org, debian-glibc@lists.debian.org
Subject: Re: Userland headers available
Message-ID: <20040123184755.GA2138@nevyn.them.org>
Mail-Followup-To: Mariusz Mazur <mmazur@kernel.pl>,
	linux-kernel@vger.kernel.org, debian-glibc@lists.debian.org
References: <200401231907.17802.mmazur@kernel.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401231907.17802.mmazur@kernel.pl>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 23, 2004 at 07:07:17PM +0100, Mariusz Mazur wrote:
> At http://ep09.pld-linux.org/~mmazur/glibc-kernel-headers/ there are userland 
> headers for linux, derived from 2.6 kernels with lots of 2.4 compatibility 
> fixes. CVS repo can be found at cvs.pld-linux.org/glibc-kernel-headers (anon 
> and webcvs). These headers are currently used to compile a whole linux distro 
> (ftp.pld-linux.org/dists/ac) for x86, sparc, amd64, alpha and ppc, but 
> general fixes are applied to all archs since we never know if a new arch 
> won't be added (amd64 was added just a month-two ago). #1 feature is that 
> they are and will be maintained (currently three people are working on them) 
> and bugs are mostly fixed instantly. Enjoy.

I've done precisely the same thing for Debian - if I find the time,
I'll compare...

I would really like to come up with an approach to maintain this
interface definition in the kernel source.  I'm still trying to think
of a way to do it without breaking compatibility or kernel builds.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
