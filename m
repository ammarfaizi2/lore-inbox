Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbUHRGqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbUHRGqI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 02:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbUHRGqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 02:46:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:12481 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261500AbUHRGqD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 02:46:03 -0400
Date: Tue, 17 Aug 2004 23:44:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: Roland McGrath <roland@redhat.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] notify_parent cleanup
Message-Id: <20040817234409.45009377.akpm@osdl.org>
In-Reply-To: <200408180040.i7I0eM4l011117@magilla.sf.frob.com>
References: <200408180040.i7I0eM4l011117@magilla.sf.frob.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland McGrath <roland@redhat.com> wrote:
>
>  I don't know why notify_parent is an exported symbol at all.

Some leftover, I guess.

>  My inclination would be to remove it as an exported symbol,

I'll unexport it.

> ...
>  Also, why is ptrace_notify exported?

binfmt_aout.c uses it.
