Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262236AbVATQyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262236AbVATQyq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 11:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262227AbVATQu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 11:50:28 -0500
Received: from cantor.suse.de ([195.135.220.2]:7872 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262180AbVATQsi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 11:48:38 -0500
Date: Thu, 20 Jan 2005 17:48:29 +0100
From: Andi Kleen <ak@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Janos Farkas <jf-ml-k1-1087813225@lk8rp.mail.xeon.eu.org>,
       linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       Chris Bruner <cryst@golden.net>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Matt Domsch <Matt_Domsch@dell.com>
Subject: Re: COMMAND_LINE_SIZE increasing in 2.6.11-rc1-bk6
Message-ID: <20050120164829.GG450@wotan.suse.de>
References: <20050119231322.GA2287@lk8rp.mail.xeon.eu.org> <20050120162807.GA3174@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050120162807.GA3174@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> AOL:
> - lilo 22.6.1
> - CONFIG_EDD=y
> - 2.6.10-mm1 and 2.6.11-rc1 did boot
> - 2.6.11-rc1-mm1 and 2.6.11-rc1-mm2 didn't boot
> - 2.6.11-rc1-mm2 with this ChangeSet reverted boots.

What I gather so far the problem seems to only happen with lilo
and EDID together.  grub appears to work.  Or did anyone
see problems with grub too?

I'll dig a bit, but reverting for now is probably best.
Thanks Linus.

-Andi

