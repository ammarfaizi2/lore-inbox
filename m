Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266605AbUFWTBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266605AbUFWTBK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 15:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266609AbUFWTBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 15:01:10 -0400
Received: from peabody.ximian.com ([130.57.169.10]:8344 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S266605AbUFWS7c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 14:59:32 -0400
Subject: Re: status of Preemptible Kernel 2.6.7
From: Robert Love <rml@ximian.com>
To: Timothy Miller <miller@techsource.com>
Cc: Marcus Hartig <m.f.h@web.de>, linux-kernel@vger.kernel.org
In-Reply-To: <40D9C48C.4060004@techsource.com>
References: <40D9B20A.4070409@web.de>  <40D9C48C.4060004@techsource.com>
Content-Type: text/plain
Date: Wed, 23 Jun 2004 14:59:31 -0400
Message-Id: <1088017171.14159.2.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.8 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-06-23 at 13:57 -0400, Timothy Miller wrote:

> I vaguely recall someone recently talking about eliminating preempt by 
> improving low-latency.  See, if everything were ideal, we wouldn't need 
> preempt, because all drivers would yield the CPU at appropriate times. 

If everything held locks for only sane periods of time, we would not
need gross explicit yielding all over the place.

To answer Marcus's question: go for it and use it.

	Robert Love


