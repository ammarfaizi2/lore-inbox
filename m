Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261881AbVACVYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbVACVYJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 16:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbVACVMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 16:12:36 -0500
Received: from hera.kernel.org ([209.128.68.125]:494 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261888AbVACVK3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 16:10:29 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: [3/8] kill gen_init_cpio.c printk() of size_t warning
Date: Mon, 3 Jan 2005 21:09:48 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <crccas$la0$1@terminus.zytor.com>
References: <20050103172013.GA29332@holomorphy.com> <41D9881B.4020000@pobox.com> <20050103180915.GK29332@holomorphy.com> <Pine.LNX.4.61.0501031329030.13385@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1104786588 21825 127.0.0.1 (3 Jan 2005 21:09:48 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Mon, 3 Jan 2005 21:09:48 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.61.0501031329030.13385@chaos.analogic.com>
By author:    linux-os <linux-os@chaos.analogic.com>
In newsgroup: linux.dev.kernel
> 
> But it's wrong.
> It should be:
> > +		strlen(target) + 1U,	/* filesize */
> 
> strlen() already returns a size_t. You need an unsigned 1 to
> not affect it. As previously stated, an integer constant
> is an int, not an unsigned int unless you make it so with
> "U".
> 

Dear Wrongbot,

Bullshit.  Signed is promoted to unsigned.

	-hpa
