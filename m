Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751454AbWC3CqQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbWC3CqQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 21:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbWC3CqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 21:46:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:65196 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751454AbWC3CqP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 21:46:15 -0500
Date: Wed, 29 Mar 2006 18:45:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: y-goto@jp.fujitsu.com, linux-kernel@vger.kernel.org
Subject: Re: [Patch:001/011] Configureable NODES_SHIFT (Generic part)
Message-Id: <20060329184559.3c2943eb.akpm@osdl.org>
In-Reply-To: <20060329184412.63e5f2d6.akpm@osdl.org>
References: <20060330105135.DC9F.Y-GOTO@jp.fujitsu.com>
	<20060330110304.DCA1.Y-GOTO@jp.fujitsu.com>
	<20060329184412.63e5f2d6.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> Yasunori Goto <y-goto@jp.fujitsu.com> wrote:
> >
> > 
> > This is generic part.
> > include/asm-xxx/numnodes.h becomes not necessary.
> > 
> 
> One thing which we aim to do where practical is to ensure that the kernel
> compiles and builds at each step of a patch series.  Mainly because it is
> very painful when git-bisect hits a won't-compile point.
> 

Of course the easy solution is to make it all a single patch.  I'll do that.
