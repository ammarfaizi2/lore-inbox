Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268035AbUJOBzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268035AbUJOBzX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 21:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268101AbUJOBzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 21:55:23 -0400
Received: from mproxy.gmail.com ([216.239.56.247]:26696 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268035AbUJOBzV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 21:55:21 -0400
Message-ID: <c0a09e5c041014185545517031@mail.gmail.com>
Date: Thu, 14 Oct 2004 18:55:20 -0700
From: Andrew Grover <andy.grover@gmail.com>
Reply-To: Andrew Grover <andy.grover@gmail.com>
To: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: 4level page tables for Linux II
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <pan.2004.10.14.16.57.23.884792@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1097638599.2673.9668.camel@cube>
	 <20041013092221.471f7232.ak@suse.de>
	 <pan.2004.10.14.16.57.23.884792@smurf.noris.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Oct 2004 18:57:24 +0200, Matthias Urlichs
<smurf@smurf.noris.de> wrote:
> Hi, Andi Kleen wrote:
> 
> > And when you cannot remember the few names for the level you
> > better shouldn't touch VM at all.
> 
> Disagree. Rather strongly in fact.
> 
> It's probably OK if you already know the stuff and have been hacking
> Linux' mm for years already, but if you try to learn how things work by
> actually looking at the code..?
> 
> Just number them. Let pd1 point to pages, pd2 to pd1 entries, and so on.
> (Level zero is the actual pages.)

I happen to agree, but surely this can be addressed at our leisure,
after pml4 is in.

Maybe a good task for the kernel janitors, if we all agree more
sensible names are desirable.

Regards -- Andy
