Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751257AbWBCBQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbWBCBQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 20:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWBCBQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 20:16:27 -0500
Received: from smtp.osdl.org ([65.172.181.4]:463 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751257AbWBCBQ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 20:16:26 -0500
Date: Thu, 2 Feb 2006 17:18:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: Bojan Smojver <bojan@rexursive.com>
Cc: nigel@suspend2.net, suspend2-devel@lists.suspend2.net, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, pavel@ucw.cz
Subject: Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.
Message-Id: <20060202171812.49b86721.akpm@osdl.org>
In-Reply-To: <20060203120055.0nu3ym4yuck0os84@imp.rexursive.com>
References: <20060201113710.6320.68289.stgit@localhost.localdomain>
	<20060202152316.GC8944@ucw.cz>
	<20060202132708.62881af6.akpm@osdl.org>
	<200602030918.07006.nigel@suspend2.net>
	<20060203120055.0nu3ym4yuck0os84@imp.rexursive.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bojan Smojver <bojan@rexursive.com> wrote:
>
> Bottom line: With your code, my machine works. Without it, it doesn't.

This leaves us in rather awkward position.  You see, there will be other
people whose machines don't work with suspend2 but which do work with
swsusp.  And other people who prefer swsusp for other reasons.

It'd help if we knew _why_ your machine doesn't work with swsusp so we can
fix it.  Futhermore it'd help if we knew specifically what you prefer about
suspend2 so we can understand what more needs to be done, and how we should
do it.
