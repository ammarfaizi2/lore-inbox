Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932541AbVINV3p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932541AbVINV3p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 17:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932561AbVINV3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 17:29:45 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:27405 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932541AbVINV3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 17:29:45 -0400
Date: Wed, 14 Sep 2005 22:29:39 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: adobriyan@gmail.com, spyro@f2s.com, domen@coderock.org,
       linux-kernel@vger.kernel.org, philb@gnu.org
Subject: Re: [PATCH] Remove drivers/parport/parport_arc.c
Message-ID: <20050914222938.E30746@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, adobriyan@gmail.com,
	spyro@f2s.com, domen@coderock.org, linux-kernel@vger.kernel.org,
	philb@gnu.org
References: <20050914202420.GK19491@mipter.zuzino.mipt.ru> <20050914220837.D30746@flint.arm.linux.org.uk> <20050914141631.1567758b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050914141631.1567758b.akpm@osdl.org>; from akpm@osdl.org on Wed, Sep 14, 2005 at 02:16:31PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2005 at 02:16:31PM -0700, Andrew Morton wrote:
> Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> >
> > On Thu, Sep 15, 2005 at 12:24:20AM +0400, Alexey Dobriyan wrote:
> > > From: Domen Puncer <domen@coderock.org>
> > > 
> > > Remove nowhere referenced file (grep "parport_arc\." didn't find anything).
> > 
> > Maybe Ian Molton might like to ensure that this is linked in to the
> > build.
> > 
> 
> Yeah, except it's also unused in 2.4 and includes non-existent header
> files.  Probably it's an ex-parrot but it'd be worth an attempt to get
> it to compile before we remove it.

True - I never had a machine which parport_arc was used on, so it
existed from the time when parport was initially written and remained
in that rather sad state.  The only person I know who may have tinkered
with it would be Dave Gilbert.

However, it's now within the set of machines which Ian looks after, so
Ian should at least know of its impending demise.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
