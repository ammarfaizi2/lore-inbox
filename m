Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbUCICqo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 21:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261499AbUCICqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 21:46:43 -0500
Received: from fw.osdl.org ([65.172.181.6]:15803 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261498AbUCICqm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 21:46:42 -0500
Date: Mon, 8 Mar 2004 18:46:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: objrmap-core-1 (rmap removal for file mappings to avoid 4:4 in
 <=16G machines)
Message-Id: <20040308184651.75718045.akpm@osdl.org>
In-Reply-To: <20040308223415.GB12612@dualathlon.random>
References: <20040308202433.GA12612@dualathlon.random>
	<20040308130231.59deef80.akpm@osdl.org>
	<20040308223415.GB12612@dualathlon.random>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
>  > I don't recall that the objrmap patches ever significantly affected CPU
>  > utilisation.
> 
>  it does, the number precisely is a 30% figure slowdown in kernel compiles.

I think this might have been increased system time, not increased runtime.

>  also check any readprofile in any of your boxes, rmap is at the very
>  top.

With super-forky workloads, yes.  But we were somewhat disappointed in the
(lack of) improvements which [an]objrmap offered.

It sounds like a bunch of remeasuring is needed.  No doubt someone will do
this as we move these patches along.
