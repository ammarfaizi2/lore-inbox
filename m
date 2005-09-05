Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932488AbVIEUZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932488AbVIEUZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 16:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932487AbVIEUZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 16:25:26 -0400
Received: from fincher.users.accretive-networks.net ([216.127.44.4]:4863 "EHLO
	fincher.users.accretive-networks.net") by vger.kernel.org with ESMTP
	id S932488AbVIEUZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 16:25:25 -0400
Date: Mon, 5 Sep 2005 13:25:17 -0700 (PDT)
From: Moses Leslie <marmoset@malformed.org>
X-X-Sender: moses@fincher.users.accretive-networks.net
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13 lockup at boot after/at cpu initialization
In-Reply-To: <20050901210551.5d5aa53b.akpm@osdl.org>
Message-ID: <20050905132341.L57406@fincher.users.accretive-networks.net>
References: <20050901164145.Q7547@fincher.users.accretive-networks.net>
 <20050901210551.5d5aa53b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Sep 2005, Andrew Morton wrote:

> You may get some more output if you add `earlyprintk=vga' to the kernel
> boot command line.
>

Hi Andrew,

Thanks for the reply, and sorry for the delay in response.

It turns out that I think it's an error on my end.  The kernel didn't
actually crash, it just doesn't print anything to the screen after the
lines I pasted.  It appears to boot normally after that.

My guess is some sort of console handler is missing, I will try to figure
out what that might be.

Sorry for the false alarm.

Moses
