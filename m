Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932293AbWGGXDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbWGGXDU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 19:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbWGGXDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 19:03:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28333 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932293AbWGGXDT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 19:03:19 -0400
Date: Fri, 7 Jul 2006 16:06:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Bligh <mbligh@mbligh.org>
Cc: reuben-lkml@reub.net, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm6
Message-Id: <20060707160650.44543c3a.akpm@osdl.org>
In-Reply-To: <44AED530.8040802@mbligh.org>
References: <20060703030355.420c7155.akpm@osdl.org>
	<44AE268F.7080409@reub.net>
	<20060707023518.f621bcf2.akpm@osdl.org>
	<44AECEDD.201@reub.net>
	<20060707143854.4a8fd106.akpm@osdl.org>
	<44AED530.8040802@mbligh.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Bligh <mbligh@mbligh.org> wrote:
>
> 
> > Yikes!  Until we fix that there's no point in looking at anything else.
> > 
> > CONFIG_DEBUG_PAGEALLOC would nail this bug in a flash, but x86_64 doesn't
> > implement the damn thing :(
> 
> I have an implementation, but there's some bug in it I never fixed. If
> you want it, I'll update it  and send it out ... maybe you can spot the
> bug ;-(
> 

My bug-spotting rate doesn't seem so good lately.  But if the thing doesn't
break the kernel when configged off then sure, let's put it in -mm with a
big doesnt-work-yet warning on it and hopefully some clever person like
Chuck will come along and fix it.

That being said, we don't seem to be getting a lot of value from
DEBUG_PAGEALLOC any more.  I guess we fixed a pile of long-standing
problems when it first went in and the reintroduction rate is low.

