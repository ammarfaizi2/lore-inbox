Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268081AbUHQDUx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268081AbUHQDUx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 23:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268082AbUHQDUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 23:20:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:10217 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268081AbUHQDUv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 23:20:51 -0400
Date: Mon, 16 Aug 2004 20:19:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm1
Message-Id: <20040816201915.544df590.akpm@osdl.org>
In-Reply-To: <20040817030957.GI11200@holomorphy.com>
References: <20040816143710.1cd0bd2c.akpm@osdl.org>
	<20040817030748.GH11200@holomorphy.com>
	<20040817030957.GI11200@holomorphy.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> On Mon, Aug 16, 2004 at 02:37:10PM -0700, Andrew Morton wrote:
> >> - This kernel probably still has the ia64 scheduler startup bug, although it
> >>   works For Me.
> 
> On Mon, Aug 16, 2004 at 08:07:48PM -0700, William Lee Irwin III wrote:
> > AIUI that was fixed by kill-clone-idletask-fix.patch
> 
> How did you compile on ia64? I get:

I suspect I got lucky.

> make: *** No rule to make target `.tmp_kallsyms3.S', needed by `.tmp_kallsyms3.o'.  Stop.
> 

People are saying that `make -j1' will work around this.
