Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030183AbVKGXIP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030183AbVKGXIP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 18:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965591AbVKGXIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 18:08:14 -0500
Received: from smtp.osdl.org ([65.172.181.4]:40635 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965589AbVKGXIN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 18:08:13 -0500
Date: Mon, 7 Nov 2005 15:08:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: zach@vmware.com, rmk@arm.linux.org.uk, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, davej@redhat.com, than@redhat.com
Subject: Re: [PATCH 1/1] My tools break here
Message-Id: <20051107150807.5f85ec13.akpm@osdl.org>
In-Reply-To: <20051107225024.GB10492@mars.ravnborg.org>
References: <200511072156.jA7LuQKv009711@zach-dev.vmware.com>
	<20051107225024.GB10492@mars.ravnborg.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg <sam@ravnborg.org> wrote:
>
> On Mon, Nov 07, 2005 at 01:56:26PM -0800, Zachary Amsden wrote:
> > I have to revert the recent addition of -imacros to the Makefile to get my
> > tool chain to build.  Without the change, below, I get:
> > 
> > Note that this looks entirely like a toolchain bug.
> Then fix your toolchain instead of reverting the -imacros patch.

Well.   We work around toolchain bugs regularly.

> The change has been in -git for a full day and in latest -mm too.
> And so far this is the only report that it breaks - I no one else
> complains it will stay.

Let's wait and see how many more people are affected.
