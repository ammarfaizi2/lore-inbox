Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266519AbUHaE2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266519AbUHaE2c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 00:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266531AbUHaE2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 00:28:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:53146 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266519AbUHaE2a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 00:28:30 -0400
Date: Mon, 30 Aug 2004 21:26:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Roland McGrath <roland@redhat.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cleanup ptrace stops and remove notify_parent
Message-Id: <20040830212632.392cf5f5.akpm@osdl.org>
In-Reply-To: <200408310411.i7V4B8Vs027772@magilla.sf.frob.com>
References: <20040830204332.24da5615.akpm@osdl.org>
	<200408310411.i7V4B8Vs027772@magilla.sf.frob.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland McGrath <roland@redhat.com> wrote:
>
> > It clashes significantly with your waitid syscall patch.  Which one do you
>  > believe has priority?
> 
>  I of course already have a tree with both reconciled.  I did this ptrace
>  patch independently against Linus's tree since it was based on suggestions
>  from Linus and I thought he might like to try it and perhaps merge it
>  before my other patches in -mm go in.

Well given that waitid ha baked for a bit longer I guess we'd best make
this patch come afterwards.  So if you could redo this patch against
rc1-mm1, please?

