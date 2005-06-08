Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbVFHBrp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbVFHBrp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 21:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbVFHBrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 21:47:45 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:36361 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S262062AbVFHBrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 21:47:41 -0400
Date: Wed, 8 Jun 2005 09:52:16 +0800 (WST)
From: Ian Kent <raven@themaw.net>
X-X-Sender: raven@wombat.indigo.net.au
To: Adrian Bunk <bunk@stusta.de>
cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: RFC: i386: kill !4KSTACKS
In-Reply-To: <20050607212706.GB7962@stusta.de>
Message-ID: <Pine.LNX.4.58.0506080948540.29656@wombat.indigo.net.au>
References: <20050607212706.GB7962@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-102.5, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, QUOTED_EMAIL_TEXT, REFERENCES,
	REPLY_WITH_QUOTES, USER_AGENT_PINE, USER_IN_WHITELIST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jun 2005, Adrian Bunk wrote:

> 4Kb kernel stacks are the future on i386, and it seems the problems it 
> initially caused are now sorted out.
> 
> I'd like to:
> - get a patch into the next -mm that unconditionally enables 4KSTACKS
> - if there won't be new reports of breakages, send a patch to
>   completely remove !4KSTACKS for 2.6.13 or 2.6.14
> 
> The only drawback is that REISER4_FS does still depend on !4KSTACKS.
> I told Hans back in March that this has to be changed.

What about ndiswrapper?
Why is it so important to make this happen unconditionally?

Will you maintain a patch for those of us that need it?

Ian

