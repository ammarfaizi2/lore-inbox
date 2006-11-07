Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754160AbWKGKOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754160AbWKGKOc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 05:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754171AbWKGKOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 05:14:32 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:60605 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1754160AbWKGKOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 05:14:31 -0500
Date: Tue, 7 Nov 2006 11:13:44 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andy Whitcroft <apw@shadowen.org>
Cc: schwidefsky@de.ibm.com, linux390@de.ibm.com, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-390@vm.marist.edu
Subject: Re: [PATCH] s390 need definitions for pagefault_disable and pagefault_enable
Message-ID: <20061107101344.GB7057@osiris.boeblingen.de.ibm.com>
References: <20061101235407.a92f94a5.akpm@osdl.org> <7e94d9e3967f67b1151689921a21fd65@pinky> <20061107081326.GA7057@osiris.boeblingen.de.ibm.com> <45505B68.7000607@shadowen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45505B68.7000607@shadowen.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2006 at 10:09:44AM +0000, Andy Whitcroft wrote:
> Heiko Carstens wrote:
> > On Mon, Nov 06, 2006 at 06:35:21PM +0000, Andy Whitcroft wrote:
> >> diff --git a/arch/s390/lib/uaccess_std.c b/arch/s390/lib/uaccess_std.c
> >> index 9bbeaa0..ad296dc 100644
> >> --- a/arch/s390/lib/uaccess_std.c
> >> +++ b/arch/s390/lib/uaccess_std.c
> >> @@ -11,6 +11,8 @@
> >>  
> >>  #include <linux/errno.h>
> >>  #include <linux/mm.h>
> >> +#include <linux/uaccess.h>
> >> +
> >>  #include <asm/uaccess.h>
> >>  #include <asm/futex.h>
> > 
> > http://lkml.org/lkml/2006/11/2/54
> > 
> > ;)
> 
> Perhaps it would be helpful if these went out as replies to akpm's -mm
> announcement else you have to sift the whole of lkml for them :(.

??? It was the first reply to the -mm accouncement and that's where you
can find it in the tree: http://lkml.org/lkml/2006/11/2/33
