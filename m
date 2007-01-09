Return-Path: <linux-kernel-owner+w=401wt.eu-S932518AbXAIXWb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932518AbXAIXWb (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 18:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932521AbXAIXWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 18:22:31 -0500
Received: from smtp.osdl.org ([65.172.181.24]:53069 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932518AbXAIXWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 18:22:30 -0500
Date: Tue, 9 Jan 2007 15:21:51 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Jean Delvare <khali@linux-fr.org>, Andrey Borzenkov <arvidjaar@mail.ru>,
       linux-kernel@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>,
       Herbert Poetzl <herbert@13thfloor.at>, Olaf Hering <olaf@aepfle.de>
Subject: Re: .version keeps being updated
In-Reply-To: <20070109133121.194f3261.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0701091520280.3594@woody.osdl.org>
References: <20070109102057.c684cc78.khali@linux-fr.org>
 <20070109170550.AFEF460C343@tzec.mtu.ru> <20070109214421.281ff564.khali@linux-fr.org>
 <20070109133121.194f3261.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 9 Jan 2007, Andrew Morton wrote:
> 
> > This new behavior of the kernel build system is likely to
> > make developers angry pretty quickly.
> 
> That might motivate them to fix it ;)

Actually, how about just removing the incrementing version count entirely?

I realize that it's really really old, and has been there basically since 
day one, but on the other hand, it's old not because it's fundamentally 
important, but because it's just been maintained. How about just dropping 
it entirely?

We have more useful _real_ versioning these days, with git commit ID's 
etc.

		Linus
