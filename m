Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751098AbWEVRyI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbWEVRyI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 13:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbWEVRyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 13:54:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32914 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751098AbWEVRyG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 13:54:06 -0400
Date: Mon, 22 May 2006 10:53:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: zach@vmware.com, jakub@redhat.com, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org, torvalds@osdl.org,
       virtualization@lists.osdl.org, kraxel@suse.de
Subject: Re: [PATCH] Gerd Hoffman's move-vsyscall-into-user-address-range
 patch
Message-Id: <20060522105329.1e0bdacf.akpm@osdl.org>
In-Reply-To: <20060522172710.GA22823@elte.hu>
References: <1147759423.5492.102.camel@localhost.localdomain>
	<20060516064723.GA14121@elte.hu>
	<1147852189.1749.28.camel@localhost.localdomain>
	<20060519174303.5fd17d12.akpm@osdl.org>
	<20060522162949.GG30682@devserv.devel.redhat.com>
	<4471EA60.8080607@vmware.com>
	<20060522101454.52551222.akpm@osdl.org>
	<20060522172710.GA22823@elte.hu>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> is it really a big problem to add "vdso=0" to the long list of 
>  requirements you need to run a 2.6 kernel on an old distribution (or to 
>  disable CONFIG_VDSO)? FC1 wasnt even 2.6-ready, it used a 2.4 kernel!

I assume that FC1-using people aren't the only ones who will be affected by
this.  We just don't know.

Oh well.  One way of finding out is to ship the thing ;)

I seem to have lost the vdso=0 patch and the CONFIG_VDSO patch.  Resend,
please?

