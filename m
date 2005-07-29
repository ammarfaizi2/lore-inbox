Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262747AbVG2TJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262747AbVG2TJF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 15:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262707AbVG2TGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 15:06:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27301 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262731AbVG2TD7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 15:03:59 -0400
Date: Fri, 29 Jul 2005 12:03:55 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reboot: remove device_suspend(PMSG_FREEZE) from kernel_kexec
In-Reply-To: <m18xzp4fam.fsf@ebiederm.dsl.xmission.com>
Message-ID: <Pine.LNX.4.58.0507291202130.3307@g5.osdl.org>
References: <m18xzp4fam.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Jul 2005, Eric W. Biederman wrote:
> 
> If device_suspend(PMSG_FREEZE) is not ready to be called in
> kernel_restart it is definitely ready to be called in the more the
> more fickle kernel_kexec. 

Ok, that was one of the more confused sentences I have ever seen, but I 
fixed it up and applied it ;)

I assume it should be "definitely <not> ready", and the duplication the
duplication in "the more the more" is just because you're singing along 
with some catchy tune and your fingers got away from you.

		Linus
