Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754780AbWKIKKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754780AbWKIKKd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 05:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754783AbWKIKKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 05:10:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:55232 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1754780AbWKIKKb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 05:10:31 -0500
X-Authenticated: #14349625
Subject: Re: 2.6.19-rc5 breaks klogd 1.4.1
From: Mike Galbraith <efault@gmx.de>
To: Andrew Morton <akpm@osdl.org>
Cc: John Wendel <jwendel10@comcast.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20061108233517.7cc1db12.akpm@osdl.org>
References: <4552BB55.9090400@comcast.net>
	 <20061108224153.4ed2e581.akpm@osdl.org> <4552D4B4.5020505@comcast.net>
	 <20061108233517.7cc1db12.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 09 Nov 2006 11:11:04 +0100
Message-Id: <1163067064.6145.4.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-08 at 23:35 -0800, Andrew Morton wrote:

> And, predictably, reads from /proc/kmsg aren't blocking.
> 
> I can't see what might have caused that.  Are you sure that 2.6.19-rc4 was
> OK?  And are you sure that nothing else has changed on that system?

Here, both rc4 and rc5 do the same if printk is configured out.

Why do we have a /proc/ksmg when nothing can get to it?

	-Mike

