Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932188AbWF0LFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbWF0LFq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 07:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933315AbWF0LFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 07:05:46 -0400
Received: from mail.gmx.net ([213.165.64.21]:30103 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932188AbWF0LFp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 07:05:45 -0400
X-Authenticated: #5039886
Date: Tue, 27 Jun 2006 13:06:02 +0200
From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] irq: fix arch/i386/kernel/irq.c gcc warning
Message-ID: <20060627110602.GA11051@atjola.homenet>
Mail-Followup-To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
References: <20060627015211.ce480da6.akpm@osdl.org> <20060627092801.GA4196@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060627092801.GA4196@elte.hu>
User-Agent: Mutt/1.5.11+cvs20060403
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006.06.27 11:28:01 +0200, Ingo Molnar wrote:
> 
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm3/
> 
> > Changes since 2.6.17-mm2:
> > 
> >  origin.patch
> 
> upstream grew a new compiler warning in i386 irq.c. Patch below fixes 
> it. No change in resulting irq.o code.

Yep, that's my fault, Jean Delvare did also sent a patch yesterday.

http://lkml.org/lkml/2006/6/26/380

Björn
