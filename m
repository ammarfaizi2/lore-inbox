Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262030AbVGLSkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbVGLSkP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 14:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262022AbVGLSj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 14:39:59 -0400
Received: from [192.94.73.30] ([192.94.73.30]:31201 "EHLO sdf.lonestar.org")
	by vger.kernel.org with ESMTP id S262030AbVGLSjS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 14:39:18 -0400
From: Jim Nance <jlnance@sdf.lonestar.org>
Date: Tue, 12 Jul 2005 18:38:59 +0000
To: Peter Staubach <staubach@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel header policy
Message-ID: <20050712183859.GA21230@SDF.LONESTAR.ORG>
References: <200507120206.j6C26kGY017571@laptop11.inf.utfsm.cl> <42D3C51D.3020703@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42D3C51D.3020703@redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2005 at 09:26:53AM -0400, Peter Staubach wrote:

> I must admit a little confusion here.  Clearly, kernel header files are
> used at the user level.  The kernel and user level applications must share
> definitions for a great many things.

Perhaps a little history would help.  In the beginning, the kernel was
written with the intention that userland would be including the headers.
And libc did include the kernel headers.

This did provide an effective way to get new kernel features to show
up in userland, but it created all sorts of other problems.  Eventually
it was decided/decreed that userland would NOT include kernel headers.
Instead, libc would provide a set of headers which would either be
compatable, or would marshel data into the form the kernel wanted.

I don't remember exactly when this was done, but I believe it was
some time in the late 90s.  It's been this way a while now.

Thanks,

Jim

-- 
jlnance@sdf.lonestar.org
SDF Public Access UNIX System - http://sdf.lonestar.org
