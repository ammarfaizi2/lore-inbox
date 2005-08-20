Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932650AbVHTDZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932650AbVHTDZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 23:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932651AbVHTDZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 23:25:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17092 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932650AbVHTDZ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 23:25:57 -0400
Date: Fri, 19 Aug 2005 20:24:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [patch 2.6.13-rc6] docs: fix misinformation about
 overcommit_memory
Message-Id: <20050819202426.5208961e.akpm@osdl.org>
In-Reply-To: <200508192318_MC3-1-A7AE-1D7A@compuserve.com>
References: <200508192318_MC3-1-A7AE-1D7A@compuserve.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert <76306.1226@compuserve.com> wrote:
>
> +Controls overcommit of system memory:

It should explain what "overcommit" is.

>  +
>  +0	-	Heuristic overcommit handling. Obvious overcommits of
>  +		address space are refused. Used for a typical system. It
>  +		ensures a seriously wild allocation fails while allowing
>  +		overcommit to reduce swap usage.  root is allowed to
>  +		allocate slighly more memory in this mode. This is the
>  +		default.
>  +
>  +1	-	Always overcommit. Appropriate for some scientific
>  +		applications.
>  +
>  +2	-	Don't overcommit. The total address space commit
>  +		for the system is not permitted to exceed swap + a
>  +		configurable percentage (default is 50) of physical RAM.

Configurable how?

>  +		Depending on the percentage you use, in most situations
>  +		this means a process will not be killed while accessing
>  +		pages but will receive errors on memory allocation as
>  +		appropriate.
