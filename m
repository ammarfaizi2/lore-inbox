Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261617AbVAGViV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbVAGViV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 16:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261625AbVAGVgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 16:36:46 -0500
Received: from fw.osdl.org ([65.172.181.6]:44946 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261622AbVAGVfl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 16:35:41 -0500
Date: Fri, 7 Jan 2005 13:40:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, marado@student.dei.uc.pt
Subject: Re: grsecurity 2.1.0 release / 5 Linux kernel advisories (fwd)
Message-Id: <20050107134014.3ac297f3.akpm@osdl.org>
In-Reply-To: <4d8e3fd305010713032aeaa75c@mail.gmail.com>
References: <Pine.LNX.4.61.0501071954130.361@student.dei.uc.pt>
	<4d8e3fd305010713032aeaa75c@mail.gmail.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> wrote:
>
> the below email seems to be very intersting.

An unprivileged local user can DoS a Linux box to death with malloc and
memset, so the RLIMIT_MEMLOCK bug isn't particularly exceptional.  All the
others require root anyway.

I'll pass this on to appropriate people, see if we can get this all fixed
up, thanks.

