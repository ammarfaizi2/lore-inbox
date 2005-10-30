Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932383AbVJ3W4W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbVJ3W4W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 17:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbVJ3W4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 17:56:21 -0500
Received: from smtp.osdl.org ([65.172.181.4]:17610 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932383AbVJ3W4V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 17:56:21 -0500
Date: Sun, 30 Oct 2005 14:55:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: ak@suse.de, torvalds@osdl.org, tony.luck@gmail.com,
       paolo.ciarrocchi@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: New (now current development process)
Message-Id: <20051030145533.5733b12d.akpm@osdl.org>
In-Reply-To: <20051030224524.GG2846@flint.arm.linux.org.uk>
References: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com>
	<12c511ca0510291157u5557b6b1x85a47311f0e16436@mail.gmail.com>
	<20051029195115.GD14039@flint.arm.linux.org.uk>
	<Pine.LNX.4.64.0510291314100.3348@g5.osdl.org>
	<p73r7a4t0s7.fsf@verdi.suse.de>
	<20051029223723.GJ14039@flint.arm.linux.org.uk>
	<20051030111241.74c5b1a6.akpm@osdl.org>
	<20051030214309.GE2846@flint.arm.linux.org.uk>
	<20051030143103.17f2835c.akpm@osdl.org>
	<20051030224524.GG2846@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
>
>  That's fine if you have the hardware to be able to debug these issues.

Most driver bugs cannot be reproduced by the developer.  Almost by
definition: if the patch had caused problems on the developer's machine, he
wouldn't have shipped it.

This is why we have this wonderful group of long-suffering people who
download and test development kernels for us, and who take the time to
report defects.

Yes, it's painful to get into a long-range debugging session, sending debug
patches, twelve-hour turnaround, etc.  But what alternative have we?
