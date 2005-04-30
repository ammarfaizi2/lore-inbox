Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263119AbVD3BZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263119AbVD3BZp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 21:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263120AbVD3BZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 21:25:45 -0400
Received: from fire.osdl.org ([65.172.181.4]:51333 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263119AbVD3BZj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 21:25:39 -0400
Date: Fri, 29 Apr 2005 18:25:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mauricio Lin <mauriciolin@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] A new entry for /proc
Message-Id: <20050429182511.7df7d712.akpm@osdl.org>
In-Reply-To: <3f250c71050429113616a55f28@mail.gmail.com>
References: <3f250c7105010613115554b9d9@mail.gmail.com>
	<20050106202339.4f9ba479.akpm@osdl.org>
	<3f250c71050429113616a55f28@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mauricio Lin <mauriciolin@gmail.com> wrote:
>
> I sent some months ago the PATCH about smaps entry. Here is the new
>  one with more features included. People that want to perform a memory
>  consumption analysing can use it mainly if someone needs to figure out
>  which libraries can be reduced for embedded systems. So the new
>  features are the physical size of shared and clean [or dirty]; private
>  and clean [or dirty]. Do you think this is important for Linux
>  community?

Well I like it - a couple of years ago an engineer at Digeo developed
basically the same thing as an aid to working out "where the hack has all
our memory gone" for an embedded system.

Some people will get upset about the general performance and scheduling
latency issues which it will introduce.  But whatever - I've added it to
-mm.

