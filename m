Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262679AbTKTSwj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 13:52:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262731AbTKTSwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 13:52:39 -0500
Received: from users.ccur.com ([208.248.32.211]:28743 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id S262679AbTKTSwi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 13:52:38 -0500
Date: Thu, 20 Nov 2003 13:51:50 -0500
From: Joe Korty <joe.korty@ccur.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mqueues-4.00-lib-a0.patch
Message-ID: <20031120185149.GA5735@rudolph.ccur.com>
Reply-To: Joe Korty <joe.korty@ccur.com>
References: <20031120165500.GA5569@rudolph.ccur.com.suse.lists.linux.kernel> <p73brr7otaq.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73brr7otaq.fsf@oldwotan.suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 20, 2003 at 06:15:25PM +0100, Andi Kleen wrote:
> Joe Korty <joe.korty@ccur.com> writes:
> > +#ifndef __NR_mq_open
> >  
> > +#ifdef __i386__
> >  #define __NR_mq_open		274
> > +#elif __x86_64__
> > +#define __NR_mq_open		237
> > +#else
> 
> FYI. I already allocated 237 for something else on x86-64.  The patch
> is guaranteed to get broken.

Define an offical set for Opteron and I'll use it.
Joe
