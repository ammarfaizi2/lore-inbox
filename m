Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbVHXQjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbVHXQjv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 12:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbVHXQjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 12:39:51 -0400
Received: from web33301.mail.mud.yahoo.com ([68.142.206.116]:58006 "HELO
	web33301.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751145AbVHXQjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 12:39:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=YhnrOh1EbcwMoRL3+y1QXmlKhWZL+fSeNWmiEgkIymbW8bBqEV1xcCd4DVbOgBzLkEoU6wvouAQx6RWbQXSCENtlR1SbUS0VlLYcKl/vTafPc9RrFI2d8tL69yrLWgd4jbtIeZv/noboZekCF9lpTbgE+R3RNHAx4/gp1QQesGg=  ;
Message-ID: <20050824163946.94088.qmail@web33301.mail.mud.yahoo.com>
Date: Wed, 24 Aug 2005 09:39:46 -0700 (PDT)
From: Danial Thom <danial_thom@yahoo.com>
Reply-To: danial_thom@yahoo.com
Subject: Re: 2.6.12 Performance problems
To: Patrick McHardy <kaber@trash.net>
Cc: Sven-Thorsten Dietrich <sven@mvista.com>,
       Helge Hafting <helge.hafting@aitel.hist.no>,
       linux-kernel@vger.kernel.org
In-Reply-To: <430B89BE.1020600@trash.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Patrick McHardy <kaber@trash.net> wrote:

> Danial Thom wrote:
> > None of this is helpful, but since no one has
> > been able to tell me how to tune it to
> provide
> > absolute priority to the network stack I'll
> > assume it can't be done.
> 
> The network stack already has priority over
> user processes,
> except when executed in process context, so
> preemption has
> no direct impact on briding or routing
> performance.
> 
> The reason why noone answered your question is
> because you
> don't ask but claim or assume.
> 

No, its because guys like you snip out content
when they reply, and/or only read the parts of
messages that you want to read, so when other
people enter a thread, they miss the questions
that were asked long ago. Quoting my post on Aug
22:

"All of this aside, I need to measure the raw 
capabilities of the kernel. With 'bsd OSes I can 
tell what the breaking point is by driving the 
machine to livelock. Linux seems to have a soft, 
floating capacity in that it will drop packets 
here and there for no isolatable reason. I'm 
having difficulty making a case for its use in a 
networking appliance, as dropped packets are not 
acceptable. How do I tune the "its ok to drop 
packets when x occurs" algorithm to be "its never

ok to drop packets unless x occurs" (such as a 
queue depth)? Is it possible?"

Danial





__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
