Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262320AbVAOU5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262320AbVAOU5u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 15:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbVAOU5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 15:57:50 -0500
Received: from smtp-out-02.utu.fi ([130.232.202.172]:32441 "EHLO
	smtp-out-02.utu.fi") by vger.kernel.org with ESMTP id S262320AbVAOU5q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 15:57:46 -0500
Date: Sat, 15 Jan 2005 22:57:44 +0200
From: Jan Knutar <jk-lkml@sci.fi>
Subject: Re: Linux 2.4.29-rc2
In-reply-to: <20050115205002.GO4274@stusta.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Message-id: <200501152257.44172.jk-lkml@sci.fi>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.6.2
References: <20050112151334.GC32024@logos.cnet>
 <20050115114309.GA7397@logos.cnet> <20050115205002.GO4274@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 15 January 2005 22:50, Adrian Bunk wrote:

> Do a grep for EXPORT_SYMBOL_GPL in the 2.4.29-rc2 sources.

I noticed this as well...

> It seems for some reason people didn't scream in older 2.4 releases that 
> already had the same problem in several places.

I always ASSUMED it was something wrong with my userspace because
I was only seeing this problem on one of the boxen running 2.4 that I have, I
upgraded modutils but the problem didn't vanish. Since none of the modules
which failed depmod -a were important for me I guessed there was some
other part of the ancient Rh6.1 install that was too old...
Unfortunately, I only use that machine every few months and can't test
anything :)
