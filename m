Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266288AbUBLFr1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 00:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266289AbUBLFr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 00:47:27 -0500
Received: from fw.osdl.org ([65.172.181.6]:44163 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266288AbUBLFrU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 00:47:20 -0500
Date: Wed, 11 Feb 2004 21:46:59 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>, benh@ozlabs.org
Subject: Re: PPC64 PowerMac G5 support available
In-Reply-To: <1076563481.2285.167.camel@gaston>
Message-ID: <Pine.LNX.4.58.0402112143270.5816@home.osdl.org>
References: <1076563481.2285.167.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 12 Feb 2004, Benjamin Herrenschmidt wrote:
> 
> You can pull from bk://ppc.bkbits.net/for-linus-ppc

Pulling. And yes, I didn't realize that the whole aty/radeon driver was 
new. Regardless, the bits above look obvious enough, and I'll take the new 
radeon driver too once it's ready.

> Finally, ieee1394 triggers an oops in kobject since 2.6.3-rc2, 100%
> reproduceable for me (and apparently x86 users too), so that's also
> unrelated to the G5 code.

Hmm.. I've got ieee1394 built into my standard machine without any oopses,
but I don't have any actual devices connected to it, just the host. I 
assume the problems happen only with devices plugged in?

		Linus
