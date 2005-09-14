Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932760AbVINVRF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932760AbVINVRF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 17:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932763AbVINVRF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 17:17:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39314 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932760AbVINVRE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 17:17:04 -0400
Date: Wed, 14 Sep 2005 14:16:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: adobriyan@gmail.com, spyro@f2s.com, domen@coderock.org,
       linux-kernel@vger.kernel.org, philb@gnu.org
Subject: Re: [PATCH] Remove drivers/parport/parport_arc.c
Message-Id: <20050914141631.1567758b.akpm@osdl.org>
In-Reply-To: <20050914220837.D30746@flint.arm.linux.org.uk>
References: <20050914202420.GK19491@mipter.zuzino.mipt.ru>
	<20050914220837.D30746@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
>
> On Thu, Sep 15, 2005 at 12:24:20AM +0400, Alexey Dobriyan wrote:
> > From: Domen Puncer <domen@coderock.org>
> > 
> > Remove nowhere referenced file (grep "parport_arc\." didn't find anything).
> 
> Maybe Ian Molton might like to ensure that this is linked in to the
> build.
> 

Yeah, except it's also unused in 2.4 and includes non-existent header
files.  Probably it's an ex-parrot but it'd be worth an attempt to get it
to compile before we remove it.

