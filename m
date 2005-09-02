Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030646AbVIBCK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030646AbVIBCK2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 22:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030648AbVIBCK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 22:10:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37839 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030646AbVIBCK2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 22:10:28 -0400
Date: Thu, 1 Sep 2005 19:08:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hiro Yoshioka <hyoshiok@miraclelinux.com>
Cc: ak@suse.de, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       hyoshiok@miraclelinux.com
Subject: Re: [RFC] [PATCH] cache pollution aware __copy_from_user_ll()
Message-Id: <20050901190846.479229cf.akpm@osdl.org>
In-Reply-To: <20050902.104359.26944961.hyoshiok@miraclelinux.com>
References: <20050825.135420.640917643.hyoshiok@miraclelinux.com>
	<20050901.180723.982928921.hyoshiok@miraclelinux.com>
	<200509011136.38057.ak@suse.de>
	<20050902.104359.26944961.hyoshiok@miraclelinux.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hiro Yoshioka <hyoshiok@miraclelinux.com> wrote:
>
> From: Andi Kleen <ak@suse.de>
> > On Thursday 01 September 2005 11:07, Hiro Yoshioka wrote:
> > 
> > > The following is the almost final version of the
> > > cache pollution aware __copy_from_user_ll() patch.
> > 
> > Looks good to me.
> > 
> > Once the filemap.c hunk is in I'll probably do something
> > similar for x86-64.
> 
> Thank you very much. What else should I do? Shall I just
> be waiting to check in the patch?
> 

I suppose I'll queue it up in -mm for a while, although I'm a bit dubious
about the whole idea...  We'll gain some and we'll lose some - how do we
know it's a net gain?
