Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262842AbUJ1JQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262842AbUJ1JQc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 05:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262846AbUJ1JQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 05:16:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:7583 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262842AbUJ1JPU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 05:15:20 -0400
Date: Thu, 28 Oct 2004 02:13:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] cputime: introduce cputime.
Message-Id: <20041028021317.48a6d0c2.akpm@osdl.org>
In-Reply-To: <OF35D2677F.494347CD-ON42256F3B.002DDBE5-42256F3B.002F22AE@de.ibm.com>
References: <20041027224805.31f5747b.akpm@osdl.org>
	<OF35D2677F.494347CD-ON42256F3B.002DDBE5-42256F3B.002F22AE@de.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
>
> > - kernel threads may have null p->signal
>  > - remove some deoptimising inlines
> 
>  Does it work with these two changes ?

Well it doesn't crash ;)

It compiles OK on a bunch of architectures, bloats the kernel by 2k and
various system monitoring tools emit sensible-looking numbers.  What should
I be looking for?

