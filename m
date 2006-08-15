Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030362AbWHOQPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030362AbWHOQPb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 12:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030364AbWHOQPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 12:15:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12951 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030362AbWHOQPb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 12:15:31 -0400
Date: Tue, 15 Aug 2006 09:15:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org, Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ian Kent <raven@themaw.net>
Subject: Re: 2.6.18-rc4-mm1
Message-Id: <20060815091503.eede7bd8.akpm@osdl.org>
In-Reply-To: <10510.1155653263@warthog.cambridge.redhat.com>
References: <20060815065035.648be867.akpm@osdl.org>
	<20060814143110.f62bfb01.akpm@osdl.org>
	<20060813133935.b0c728ec.akpm@osdl.org>
	<20060813012454.f1d52189.akpm@osdl.org>
	<10791.1155580339@warthog.cambridge.redhat.com>
	<918.1155635513@warthog.cambridge.redhat.com>
	<10510.1155653263@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2006 15:47:43 +0100
David Howells <dhowells@redhat.com> wrote:

> 
> > http://www.zip.com.au/~akpm/linux/patches/stuff/config-sony
> 
> Is this pure 2.6.18-rc4-mm1?

yup.

> This configuration has unsatisfied config
> options.

I rarely update my skeleton configs ($certain_people broke my
support-symlinked-.config patch and no two kernel builds have the same
Kconfig set anyway).

So a

	yes '' | make oldconfig

is step 1.
