Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422707AbWKIARr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422707AbWKIARr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 19:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423950AbWKIARq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 19:17:46 -0500
Received: from smtp.osdl.org ([65.172.181.4]:21711 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422707AbWKIARq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 19:17:46 -0500
Date: Wed, 8 Nov 2006 16:17:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc5-mm1
Message-Id: <20061108161732.1225730d.akpm@osdl.org>
In-Reply-To: <200611090031.35069.rjw@sisk.pl>
References: <20061108015452.a2bb40d2.akpm@osdl.org>
	<200611090031.35069.rjw@sisk.pl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Nov 2006 00:31:34 +0100
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> On Wednesday, 8 November 2006 10:54, Andrew Morton wrote:
> > 
> > Temporarily at
> > 
> > http://userweb.kernel.org/~akpm/2.6.19-rc5-mm1/
> > 
> > will turn up at
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc5/2.6.19-rc5-mm1/
> > 
> > when kernel.org mirroring catches up.
> > 
> > 
> > 
> > - Merged the Kernel-based Virtual Machine patches.  See kvm.sf.net for
> >   userspace tools, instructions, etc.
> > 
> >   It needs a recent binutils to build.
> > 
> > - The hrtimer+dynticks code still doesn't work right for machines which halt
> >   their TSC in low-power states.
> 
> On my HPC nx6325 it doesn't even reach the point in which the messages become
> visible on the console, so I'm unable to get any debug info from it.

Nice.  You're using earlyprintk?


