Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932456AbVHIIZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456AbVHIIZo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 04:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbVHIIZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 04:25:43 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:44998 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932456AbVHIIZn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 04:25:43 -0400
Date: Tue, 9 Aug 2005 01:25:31 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Simon.Derr@bull.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpuset release ABBA deadlock fix
Message-Id: <20050809012531.67cab661.pj@sgi.com>
In-Reply-To: <20050808232558.7173fdd7.akpm@osdl.org>
References: <20050808223722.22843.86768.sendpatchset@jackhammer.engr.sgi.com>
	<20050808232558.7173fdd7.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew asked:
> So..  Is this 2.6.13-safe?

I think it is safe for 2.6.13.  However it's not a big deal either way
to me.

> > +	(void) call_usermodehelper(argv[0], argv, envp, 0);
> 
> ick.  Why the cast?

Oops - my userland coding style, not my kernel coding style.

You are welcome to kill the cast, or ask me to resend, as you like.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
