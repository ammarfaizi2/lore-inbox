Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751935AbWJMWOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751935AbWJMWOV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 18:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751937AbWJMWOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 18:14:21 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:25285
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751935AbWJMWOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 18:14:20 -0400
Date: Fri, 13 Oct 2006 15:14:21 -0700 (PDT)
Message-Id: <20061013.151421.55510283.davem@davemloft.net>
To: akpm@osdl.org
Cc: bunk@stusta.de, shemminger@osdl.org, linux-kernel@vger.kernel.org,
       eranian@hpl.hp.com, sam@ravnborg.org
Subject: Re: [PATCH] rename net_random to random32
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061013120956.962a569a.akpm@osdl.org>
References: <20061012102638.7381269a@freekitty>
	<20061013181922.GB721@stusta.de>
	<20061013120956.962a569a.akpm@osdl.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Fri, 13 Oct 2006 12:09:56 -0700

> On Fri, 13 Oct 2006 20:19:22 +0200
> Adrian Bunk <bunk@stusta.de> wrote:
> 
> > EXPORT_SYMBOL's in lib-y are latent bugs (IMHO kbuild should error
> > on them):
> > 
> > The problem is that if only modules use these functions, they will be 
> > omitted from the kernel image.
> > 
> Yeah, I always get those two confused.  I moved it to obj-y, thanks.

Yep, good catch Adrian.  I've been burned by this one oto.
