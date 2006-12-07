Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032469AbWLGRCl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032469AbWLGRCl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 12:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162258AbWLGRCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 12:02:40 -0500
Received: from smtp.osdl.org ([65.172.181.25]:44626 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1162269AbWLGRCj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 12:02:39 -0500
Date: Thu, 7 Dec 2006 09:01:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: David Brownell <david-b@pacbell.net>,
       linux-arm-kernel@lists.arm.linux.org.uk, ben@fluff.org,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] WorkStruct: Fix spi_bitbang.h
Message-Id: <20061207090145.1147cd2f.akpm@osdl.org>
In-Reply-To: <28598.1165505855@redhat.com>
References: <200612070650.49232.david-b@pacbell.net>
	<20061207124419.17680.96380.stgit@warthog.cambridge.redhat.com>
	<28598.1165505855@redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Dec 2006 15:37:35 +0000
David Howells <dhowells@redhat.com> wrote:

> David Brownell <david-b@pacbell.net> wrote:
> 
> > NAK.  Headers don't compile.  A driver including this _might_ need to
> > include that header; most won't.
> 
> Please be more specific.  It compiles for myself and for Ben.  I used the
> s3c2410_defconfig configuration.  It won't compile without it.
> 

It's a simple matter to quote the gcc stderr in the patch's changelog and
it is often very useful.
