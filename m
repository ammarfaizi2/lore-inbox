Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750948AbWE3MDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbWE3MDK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 08:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbWE3MDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 08:03:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:3997 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750934AbWE3MDI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 08:03:08 -0400
X-Authenticated: #14349625
Subject: Re: [patch, -rc5-mm1] lock validator, fix NULL type->name bug
From: Mike Galbraith <efault@gmx.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1148990326.7599.4.camel@homer>
References: <20060530022925.8a67b613.akpm@osdl.org>
	 <20060530111138.GA5078@elte.hu>  <1148990326.7599.4.camel@homer>
Content-Type: text/plain
Date: Tue, 30 May 2006 14:05:25 +0200
Message-Id: <1148990725.8610.1.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-30 at 13:58 +0200, Mike Galbraith wrote:

> =====================================================
> [ BUG: possible circular locking deadlock detected! ]
> -----------------------------------------------------
> mount/2545 is trying to acquire lock:
>  (&ni->mrec_lock){--..}, at: [<b13d1563>] mutex_lock+0x8/0xa
> 
> ...and deadlocks.
> 
> I'll try to find out what it hates.

It hates NTFS.

	-Mike

