Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262973AbVGHXRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262973AbVGHXRQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 19:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262964AbVGHXQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 19:16:59 -0400
Received: from dvhart.com ([64.146.134.43]:36021 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S262955AbVGHXPC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 19:15:02 -0400
Date: Fri, 08 Jul 2005 16:14:59 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Chris Wedgwood <cw@f00f.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Message-ID: <136640000.1120864499@flay>
In-Reply-To: <20050708230303.GA19188@taniwha.stupidest.org>
References: <20050708145953.0b2d8030.akpm@osdl.org> <133660000.1120863575@flay> <20050708230303.GA19188@taniwha.stupidest.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Friday, July 08, 2005 16:03:03 -0700 Chris Wedgwood <cw@f00f.org> wrote:

> On Fri, Jul 08, 2005 at 03:59:35PM -0700, Martin J. Bligh wrote:
> 
>> I think we're talking between 2.6.12-git5 and 2.6.12-git6 right? I
>> can confirm more explicitly if really need be. 48s -> 45.5s elapsed.
> 
> That's a huge difference (5%) --- what hardware is that on?

16 CPU x440 (about a 2-3 year old NUMA box). flat 4x seems about a 1% 
gain, still statistically significant, but definitely smaller.

I'm not saying there isn't data supporting higher HZ ... I just haven't
seen it published. I get the feeling what people really want is high-res
timers anyway ... high HZ is just concealing the issue and making it
slightly less crap, not actually fixing it.

M.

