Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268088AbUI1XQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268088AbUI1XQx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 19:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268094AbUI1XQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 19:16:52 -0400
Received: from gate.crashing.org ([63.228.1.57]:40857 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268088AbUI1XQv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 19:16:51 -0400
Subject: Re: [PATCH] Fix ppc64 cross-compilation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Roland Dreier <roland@topspin.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <52is9yb5lu.fsf@topspin.com>
References: <52is9yb5lu.fsf@topspin.com>
Content-Type: text/plain
Message-Id: <1096413261.20236.17.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 29 Sep 2004 09:14:21 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-29 at 04:39, Roland Dreier wrote:
> After the "ppc64 monster cleanup," I get
> 
>     powerpc-750-linux-gnu-strip: vmlinux: File format not recognized
> 
> from my ppc32 strip command when cross-compiling a ppc64 kernel, since
> vmlinux is a 64-bit ELF file.  This patch fixes my build (and the
> resulting kernel boots fine).

Andrew: Looks good.

Ben.


