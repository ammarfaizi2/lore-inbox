Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261183AbUKRWvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbUKRWvP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 17:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263003AbUKRWtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 17:49:12 -0500
Received: from fw.osdl.org ([65.172.181.6]:44452 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262910AbUKRWnk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 17:43:40 -0500
Date: Thu, 18 Nov 2004 14:47:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: ananth@in.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       davem@davemloft.net, prasanna@in.ibm.com, suparna@in.ibm.com
Subject: Re: [PATCH] Kprobes: wrapper to define jprobe.entry
Message-Id: <20041118144746.7daa9395.akpm@osdl.org>
In-Reply-To: <20041118102641.GB8830@in.ibm.com>
References: <20041118102641.GB8830@in.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ananth N Mavinakayanahalli <ananth@in.ibm.com> wrote:
>
> Here is a patch that adds a wrapper for defining jprobe.entry to make
> it easy to handle the three dword function descriptors defined by the
> PowerPC ELF ABI.
> 
> Current patch against 2.6.10-rc2-mm1 + kprobes patch for ppc64.

I don't have the kprobes-for-ppc64 patch here.

> Changes for adding this wrapper for x86, ppc64 (tested) and x86_64 
> (untested) below. The earlier method of defining jprobe.entry will
> continue to work.

So what should I do with this?  I'm inclined to drop it until the x86_64
part has been tested and Dave has had a go at the sparc64 version.
