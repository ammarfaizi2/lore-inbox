Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965096AbVHSUmK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965096AbVHSUmK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 16:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965114AbVHSUmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 16:42:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64226 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965096AbVHSUmI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 16:42:08 -0400
Date: Fri, 19 Aug 2005 13:37:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: hch@lst.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc6-mm1: remove-asm-hdregh.patch problems
Message-Id: <20050819133729.01d7465e.akpm@osdl.org>
In-Reply-To: <20050819203424.GJ3682@stusta.de>
References: <20050819043331.7bc1f9a9.akpm@osdl.org>
	<20050819203424.GJ3682@stusta.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> On Fri, Aug 19, 2005 at 04:33:31AM -0700, Andrew Morton wrote:
> >...
> > Changes since 2.6.13-rc5-mm1:
> >...
> > +remove-asm-hdregh.patch
> > 
> >  cleanup
> >...
> 
> This patch could be improved in two respects:
> - it doesn't remove the xtensa hdreg.h
> - the "removed" files are only empty since the original files are
>   not diffed against /dev/null (or an epoch date)
> 

Thanks, I fixed those up.
