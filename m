Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264426AbUFLAXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264426AbUFLAXL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 20:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264432AbUFLAXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 20:23:11 -0400
Received: from mail.kroah.org ([65.200.24.183]:33223 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264426AbUFLAWe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 20:22:34 -0400
Date: Fri, 11 Jun 2004 17:18:22 -0700
From: Greg KH <greg@kroah.com>
To: Hanna Linder <hannal@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, hpa@zytor.com
Subject: Re: [PATCH 2.6.7-rc3] Add's class support to msr.c
Message-ID: <20040612001822.GA10389@kroah.com>
References: <146320000.1086823391@dyn318071bld.beaverton.ibm.com> <147490000.1086824437@dyn318071bld.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <147490000.1086824437@dyn318071bld.beaverton.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2004 at 04:40:37PM -0700, Hanna Linder wrote:
> --On Wednesday, June 09, 2004 04:23:11 PM -0700 Hanna Linder <hannal@us.ibm.com> wrote:
> > 
> > This patch enables class support in arch/i386/kernel/msr.c. Very simliar
> > to cpuid (with the fixes Zwane/Greg made, thanks). 
> > 
> > [root@w-hlinder2 root]# tree /sys/class/msr
> > /sys/class/msr
> >| -- msr0
> >|   `-- dev
> > `-- msr1
> >     `-- dev
> > 
> > 2 directories, 2 files
> > 
> > Please consider for testing/inclusion.
> > 
> > Signed-off-by Hanna Linder <hannal@us.ibm.com>
> > 
> > Thanks.
> > 
> > Hanna Linder
> > IBM Linux Technology Center
> 
> Thanks to Randy Dunlap for pointing out the unnecessary tabs. Fixed.

Looks good, applied thanks.

greg k-h
