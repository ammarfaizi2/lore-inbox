Return-Path: <linux-kernel-owner+w=401wt.eu-S932522AbXAIX0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932522AbXAIX0G (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 18:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932523AbXAIX0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 18:26:06 -0500
Received: from smtp.osdl.org ([65.172.181.24]:53382 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932522AbXAIX0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 18:26:04 -0500
Date: Tue, 9 Jan 2007 15:25:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jean Delvare <khali@linux-fr.org>, Andrey Borzenkov <arvidjaar@mail.ru>,
       linux-kernel@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>,
       Herbert Poetzl <herbert@13thfloor.at>, Olaf Hering <olaf@aepfle.de>
Subject: Re: .version keeps being updated
Message-Id: <20070109152534.ebfa5aa8.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701091520280.3594@woody.osdl.org>
References: <20070109102057.c684cc78.khali@linux-fr.org>
	<20070109170550.AFEF460C343@tzec.mtu.ru>
	<20070109214421.281ff564.khali@linux-fr.org>
	<20070109133121.194f3261.akpm@osdl.org>
	<Pine.LNX.4.64.0701091520280.3594@woody.osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jan 2007 15:21:51 -0800 (PST)
Linus Torvalds <torvalds@osdl.org> wrote:

> 
> 
> On Tue, 9 Jan 2007, Andrew Morton wrote:
> > 
> > > This new behavior of the kernel build system is likely to
> > > make developers angry pretty quickly.
> > 
> > That might motivate them to fix it ;)
> 
> Actually, how about just removing the incrementing version count entirely?

I use it pretty commonly to answer the question "did I remember to install
that new kernel I just built before I rebooted"?  By comparing `uname -a'
with $TOPDIR/.version.
