Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264828AbUEPVWB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264828AbUEPVWB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 17:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264827AbUEPVWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 17:22:00 -0400
Received: from fw.osdl.org ([65.172.181.6]:49332 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264817AbUEPVVy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 17:21:54 -0400
Date: Sun, 16 May 2004 14:21:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: linux-kernel@vger.kernel.org, "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [patch] kill off PC9800
Message-Id: <20040516142123.2fd8611b.akpm@osdl.org>
In-Reply-To: <1084729840.10938.13.camel@mulgrave>
References: <1084729840.10938.13.camel@mulgrave>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley <James.Bottomley@SteelEye.com> wrote:
>
>     Randy.Dunlap" <rddunlap@osdl.org> wrote:
>     >
>     >  PC9800 sub-arch is incomplete, hackish (at least in IDE), maintainers
>     >  don't reply to emails and haven't touched it in awhile.
>     
>     And the hardware is obsolete, isn't it?  Does anyone know when they were
>     last manufactured, and how popular they are?
>     
> Hey, just being obsolete is no grounds for eliminating a
> subarchitecture...

Well it's a question of whether we're likely to see increasing demand for
it in the future.  If so then it would be prudent to put some effort into
fixing it up rather than removing it.

Seems that's not the case.  I don't see a huge rush on this but if after
this discussion nobody steps up to take care of the code over the next few
weeks, it's best to remove it.
