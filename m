Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751210AbWHJT3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbWHJT3N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbWHJT3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:29:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32421 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751210AbWHJT3N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:29:13 -0400
Date: Thu, 10 Aug 2006 12:29:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>
Subject: Re: [NTP 8/9] convert to the NTP4 reference model
Message-Id: <20060810122905.b8dd7104.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0608102106180.6761@scrub.home>
References: <20060810000146.913645000@linux-m68k.org>
	<20060810001115.525351000@linux-m68k.org>
	<20060810114903.089825bc.akpm@osdl.org>
	<Pine.LNX.4.64.0608102106180.6761@scrub.home>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2006 21:14:00 +0200 (CEST)
Roman Zippel <zippel@linux-m68k.org> wrote:

> Hi,
> 
> On Thu, 10 Aug 2006, Andrew Morton wrote:
> 
> > > This converts the kernel ntp model into a model which matches the
> > > nanokernel reference implementations.
> > 
> > For the ntp ignorami amongst us...  what is a "nanokernel reference
> > implementation" and why do we want one?
> 
> It's the behaviour the current ntp daemon expects, the ntp documentation 
> has more information and a link to the package (e.g. under Debian at 
> /usr/share/doc/ntp-doc/html/kern.html).
> 

So...  the current kernel is behaving in a manner other than that which the
NTP daemon expects?  Does this cause any problems?

I'm trying to work out what reason we might have for merging this patch.
