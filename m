Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261288AbVAHT6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbVAHT6c (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 14:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbVAHT6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 14:58:32 -0500
Received: from fw.osdl.org ([65.172.181.6]:45275 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261288AbVAHT63 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 14:58:29 -0500
Date: Sat, 8 Jan 2005 11:57:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: gandalf@wlug.westbo.se, xhejtman@mail.muni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: Swapoff inifinite loops on 2.6.10-bk (was: .6.10-bk8 swapoff
 after resume)
Message-Id: <20050108115759.1e4f7fed.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0501081547260.2688-100000@localhost.localdomain>
References: <1105080812.1087.37.camel@tux.rsn.bth.se>
	<Pine.LNX.4.44.0501081547260.2688-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
>  > I'm pretty sure it's an infinite loop, I left it like that while
>  > shaving. It produces the same sound over and over again as the head
>  > seeks back in order to try again and again...
> 
>  You're right, and yes, I could then reproduce it.  Looks like I'd only
>  been testing on 3levels (HIGHMEM64G), and this only happens on 2levels.
> 
>  Patch below, please verify it fixes your problems.  And please, could
>  someone else check I haven't screwed up swapoff on 4levels (x86_64)?

Thanks.  I'll do the x86_64 testing.
