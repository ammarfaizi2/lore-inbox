Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266616AbUFWTXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266616AbUFWTXd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 15:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266618AbUFWTXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 15:23:33 -0400
Received: from peabody.ximian.com ([130.57.169.10]:29592 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S266616AbUFWTXc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 15:23:32 -0400
Subject: Re: status of Preemptible Kernel 2.6.7
From: Robert Love <rml@ximian.com>
To: Timothy Miller <miller@techsource.com>
Cc: Marcus Hartig <m.f.h@web.de>, linux-kernel@vger.kernel.org
In-Reply-To: <40D9DA4A.3070700@techsource.com>
References: <40D9B20A.4070409@web.de>  <40D9C48C.4060004@techsource.com>
	 <1088017171.14159.2.camel@betsy>  <40D9DA4A.3070700@techsource.com>
Content-Type: text/plain
Date: Wed, 23 Jun 2004 15:23:31 -0400
Message-Id: <1088018611.14161.5.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.8 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-06-23 at 15:30 -0400, Timothy Miller wrote:

> I wasn't talking about locks.  I was talking about kernel functions 
> taking long periods of time, cases where preempt has been useful to 
> reduce kernel latency.
>
> Holding locks for extended periods is something else entirely.

I know what you were talking about.  I was replying that it seems better
overall to me if we work to eliminate long lock hold times (which then
eliminates long non-preemption times) than litter the kernel with
explicit rescheduling statements.

	Robert Love


