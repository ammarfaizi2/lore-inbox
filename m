Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263778AbUHGVr6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263778AbUHGVr6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 17:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264298AbUHGVr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 17:47:58 -0400
Received: from the-village.bc.nu ([81.2.110.252]:49603 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S263778AbUHGVr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 17:47:57 -0400
Subject: Re: [PATCH] pirq_enable_irq cleanup
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andy Grover <andy@groveronline.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
In-Reply-To: <41153EE2.2060608@groveronline.com>
References: <20040804181457.GA30739@groveronline.com>
	 <1091797385.16288.24.camel@localhost.localdomain>
	 <41153EE2.2060608@groveronline.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091911523.18978.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 07 Aug 2004 21:45:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-08-07 at 21:43, Andy Grover wrote:
> So perhaps do you think there's any alternative ways we can make this 
> function understandable? I gotta believe there's a way for it to do what 
> it needs to without 5 layers of nested if()s.

I'm not actually sure all the if nesting is right looking at the code.
I don't see how the VIA stuff became an else if for example or how 
the VIA quirk works under vector mode.

