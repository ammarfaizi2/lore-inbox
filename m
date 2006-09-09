Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbWIIMOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbWIIMOr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 08:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbWIIMOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 08:14:47 -0400
Received: from mail.gmx.de ([213.165.64.20]:28397 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932103AbWIIMOq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 08:14:46 -0400
X-Authenticated: #14349625
Subject: Re: 2.6.18-rc6-mm1 breaks glibc build
From: Mike Galbraith <efault@gmx.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1157802554.2977.79.camel@pmac.infradead.org>
References: <1157809454.19305.17.camel@Homer.simpson.net>
	 <1157802554.2977.79.camel@pmac.infradead.org>
Content-Type: text/plain
Date: Sat, 09 Sep 2006 14:25:06 +0000
Message-Id: <1157811906.10627.3.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-09-09 at 12:49 +0100, David Woodhouse wrote:
> On Sat, 2006-09-09 at 13:44 +0000, Mike Galbraith wrote:

> > /lib/modules/2.6.18-rc6-mm1-smp/build/include/linux/err.h: Assembler messages:
> 
> Don't care. <linux/err.h> is not a header which is exported to userspace
> by 'make headers_install'. No userspace build, including glibc, should
> ever be able to see it.

I kinda figured that was going to be the answer, but not knowing why
glibc was doing that, I thought it was worth a mention.  Thanks.

	-Mike

