Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262882AbUCRSjS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 13:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262872AbUCRSip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 13:38:45 -0500
Received: from fw.osdl.org ([65.172.181.6]:41150 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262871AbUCRSeD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 13:34:03 -0500
Date: Thu, 18 Mar 2004 10:33:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: torvalds@osdl.org, hch@infradead.org, drepper@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: sched_setaffinity usability
Message-Id: <20040318103352.1a65126a.akpm@osdl.org>
In-Reply-To: <20040318182407.GA1287@elte.hu>
References: <40595842.5070708@redhat.com>
	<20040318112913.GA13981@elte.hu>
	<20040318120709.A27841@infradead.org>
	<Pine.LNX.4.58.0403180748070.24088@ppc970.osdl.org>
	<20040318182407.GA1287@elte.hu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
>  Right now the VDSO mostly contains code and exception-handling data, but
>  it could contain real, userspace-visible data just as much: info that is
>  only known during the kernel build. There's basically no cost in adding
>  more fields to the VDSO, and it seems to be superior to any of the other
>  approaches. Is there any reason not to do it?

It's x86-specific?
