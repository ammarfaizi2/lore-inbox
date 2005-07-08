Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262971AbVGHXbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262971AbVGHXbp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 19:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262931AbVGHXbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 19:31:39 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:60357
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S262969AbVGHX32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 19:29:28 -0400
Date: Fri, 08 Jul 2005 16:29:24 -0700 (PDT)
Message-Id: <20050708.162924.106265517.davem@davemloft.net>
To: mbligh@mbligh.org
Cc: cw@f00f.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <136640000.1120864499@flay>
References: <133660000.1120863575@flay>
	<20050708230303.GA19188@taniwha.stupidest.org>
	<136640000.1120864499@flay>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Martin J. Bligh" <mbligh@mbligh.org>
Date: Fri, 08 Jul 2005 16:14:59 -0700

> I'm not saying there isn't data supporting higher HZ ... I just haven't
> seen it published. I get the feeling what people really want is high-res
> timers anyway ... high HZ is just concealing the issue and making it
> slightly less crap, not actually fixing it.

We very much want sub-HZ timers, especially in the networking.
