Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264496AbTEJUag (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 16:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264495AbTEJUag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 16:30:36 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:13440 "EHLO
	lapdancer.baythorne.internal") by vger.kernel.org with ESMTP
	id S264496AbTEJUaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 16:30:35 -0400
Subject: Re: A way to shrink process impact on kernel memory usage?
From: David Woodhouse <dwmw2@infradead.org>
To: Timothy Miller <miller@techsource.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3EBBE10C.4060900@techsource.com>
References: <3EBBE10C.4060900@techsource.com>
Content-Type: text/plain
Organization: 
Message-Id: <1052599390.1881.7.camel@lapdancer.baythorne.internal>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5.dwmw2) 
Date: Sat, 10 May 2003 21:43:10 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-05-09 at 18:10, Timothy Miller wrote: 
> Why not allocate an 8k space and put various process-related data
> structures at the beginning of it?  Sure, a stack overflow could
> corrupt that data, but a stack overflow would be disasterous anyhow.

No reason why not at all. That's why we've been doing it this way for
years ;)

-- 
dwmw2

