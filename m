Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932410AbWFJGNl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbWFJGNl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 02:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbWFJGNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 02:13:41 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:41142 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932410AbWFJGNl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 02:13:41 -0400
Date: Sat, 10 Jun 2006 08:13:28 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: klibc - another libc?
Message-ID: <20060610061327.GD8120@mars.ravnborg.org>
References: <44869397.4000907@tls.msk.ru> <Pine.LNX.4.64.0606080036250.17704@scrub.home> <e69fu3$5ch$1@terminus.zytor.com> <Pine.LNX.4.64.0606091409220.17704@scrub.home> <e6cgjv$b8t$1@terminus.zytor.com> <Pine.LNX.4.64.0606100257550.17704@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606100257550.17704@scrub.home>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well for now you pretty much just moved code, that was in the kernel 
> before. What I'm trying to find out is what is coming next. How does e.g. 
> udev or modules fit into the picture?
udev and module-init-tools fits nicely with the kernel. I never have
understood this 'keep-everyhig-separate' mantra. Just see how many
people had troubles with missing module-init-tools or people having
troubles with non-backward compatible udev.

> For -mm that's fine, but do you seriously expect it to get merged like 
> that. Again, what makes klibc so special, that it doesn't have to follow 
> standard rules?
So part of what you ask for is a set of incremental patches that shows
all the kernal modifications?
That should be doable with some effort but unfortunately I'm not up to
the task.

	Sam
