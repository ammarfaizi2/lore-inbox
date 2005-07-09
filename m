Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261699AbVGITNU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbVGITNU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 15:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbVGITNT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 15:13:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59290 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261699AbVGITNS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 15:13:18 -0400
Date: Sat, 9 Jul 2005 12:12:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: arjan@infradead.org, azarah@nosferatu.za.org, cw@f00f.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, christoph@lameter.org
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Message-Id: <20050709121212.7539a048.akpm@osdl.org>
In-Reply-To: <1120934163.6488.72.camel@mindpipe>
References: <200506231828.j5NISlCe020350@hera.kernel.org>
	<20050708214908.GA31225@taniwha.stupidest.org>
	<20050708145953.0b2d8030.akpm@osdl.org>
	<1120928891.17184.10.camel@lycan.lan>
	<1120932991.6488.64.camel@mindpipe>
	<1120933916.3176.57.camel@laptopd505.fenrus.org>
	<1120934163.6488.72.camel@mindpipe>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> wrote:
>
>  > This is not a userspace visible thing really with few exceptions, and
>  > well people can select the one they want, right?
> 
>  Then why not leave the default at 1000?

Because some machines exhibit appreciable latency in entering low power
state via ACPI, and 1000Hz reduces their battery life.  By about half,
iirc.
