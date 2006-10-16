Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422951AbWJPXyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422951AbWJPXyd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 19:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422952AbWJPXyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 19:54:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61377 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422951AbWJPXyb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 19:54:31 -0400
Date: Mon, 16 Oct 2006 16:54:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Mark Gross <mark.gross@intel.com>
Subject: Re: [PATCH] CONFIG_TELCLOCK depends on X86
Message-Id: <20061016165426.d32352b4.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610161957520.10901@anakin>
References: <Pine.LNX.4.64.0610161957520.10901@anakin>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2006 19:59:43 +0200 (CEST)
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> The telecom clock driver for MPBL0010 ATCA SBC depends on X86
> 

But it compiles on other architectures (doesn't it?)

And perhaps sometime the hardware will be available on other architectures.

And there's benefit in being able to compile drivers on other architectures
- sometimes it will catch bugs.

IOW: what is the reason for making this change?
