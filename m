Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262901AbTKYTYq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 14:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbTKYTYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 14:24:46 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:54386 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S262901AbTKYTYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 14:24:45 -0500
Date: Tue, 25 Nov 2003 14:24:41 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.2/2.4/2.6 VMs: do malloc() ever return NULL?
In-Reply-To: <3FC3A797.4060108@softhome.net>
Message-ID: <Pine.LNX.4.44.0311251423470.9182-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Nov 2003, Ihar 'Philips' Filipau wrote:

> > # echo 2 > /proc/sys/vm/overcommit_memory
> > 
> > Then try again.
> 
>    What do you know what is not said in docs?
>    What '2' means?

Strict non-overcommit mode.  You can allocate as much
non-file-backed virtual memory as will fit in swap,
plus /proc/sys/vm/overcommit_percentage worth of memory.

>    this is what 2.6-test10 says:

OK, outdated docs.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

