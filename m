Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756807AbWKSRg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756807AbWKSRg0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 12:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756805AbWKSRg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 12:36:26 -0500
Received: from smtp.osdl.org ([65.172.181.25]:49575 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1756807AbWKSRgZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 12:36:25 -0500
Date: Sun, 19 Nov 2006 09:33:37 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch] PM: suspend/resume debugging should depend on 
 SOFTWARE_SUSPEND
In-Reply-To: <200611190320_MC3-1-D21B-111C@compuserve.com>
Message-ID: <Pine.LNX.4.64.0611190930370.3692@woody.osdl.org>
References: <200611190320_MC3-1-D21B-111C@compuserve.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 19 Nov 2006, Chuck Ebbert wrote:
>
> When doing 'make oldconfig' we should ask about suspend/resume
> debug features when SOFTWARE_SUSPEND is not enabled.

That's wrong.

I never use SOFTWARE_SUSPEND, and I think the whole concept is totally 
broken.

Sane people use suspend-to-ram, and that's when you need the suspend and 
resume debugging.

Software-suspend is silly. I want my machine back in three seconds, not 
waiting for minutes..

		Linus
