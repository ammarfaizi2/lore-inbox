Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267460AbUIFX3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267460AbUIFX3g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 19:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267474AbUIFX3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 19:29:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:19645 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267460AbUIFX3e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 19:29:34 -0400
Date: Mon, 6 Sep 2004 16:27:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: raybry@sgi.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       riel@redhat.com, piggin@cyberone.com.au, mbligh@aracnet.com
Subject: Re: swapping and the value of /proc/sys/vm/swappiness
Message-Id: <20040906162740.54a5d6c9.akpm@osdl.org>
In-Reply-To: <cone.1094512172.450816.6110.502@pc.kolivas.org>
References: <413CB661.6030303@sgi.com>
	<cone.1094512172.450816.6110.502@pc.kolivas.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:
>
> > A scan of the change logs for swappiness related changes shows nothing that 
>  > might explain these changes.  My question is:  "Is this change in behavior
>  > deliberate, or just a side effect of other changes that were made in the vm?" 
>  > and "What kind of swappiness behavior might I expect to find in future kernels?".
> 
>  The change was not deliberate but there have been some other people report 
>  significant changes in the swappiness behaviour as well (see archives). It 
>  has usually been of the increased swapping variety lately. It has been 
>  annoying enough to the bleeding edge desktop users for a swag of out-of-tree 
>  hacks to start appearing (like mine).

All of which is largely wasted effort.  It would be much more useful to get
down and identify which patch actually caused the behavioural change.
