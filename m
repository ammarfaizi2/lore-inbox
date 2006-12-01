Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933835AbWLAHQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933835AbWLAHQc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 02:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933843AbWLAHQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 02:16:31 -0500
Received: from smtp.osdl.org ([65.172.181.25]:5296 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S933835AbWLAHQ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 02:16:29 -0500
Date: Thu, 30 Nov 2006 23:16:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mike Mattie <codermattie@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: snd-usb-audio (I think) hangs apps ( audacious media
 player )  in 'D' state, linux = 2.6.18.3
Message-Id: <20061130231627.d1df7c58.akpm@osdl.org>
In-Reply-To: <20061130222145.4e5d5f0e@reforged>
References: <20061130222145.4e5d5f0e@reforged>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2006 22:21:45 -0800
Mike Mattie <codermattie@gmail.com> wrote:

> I use a soundblaster audigy 2 NX external sound card in USB 2.0 high
> speed mode. 
> 
> Until 2.6.18 pausing the player would instantly 'D' state
> audacious, requiring a re-boot. I thought it went away in 2.6.18 but
> it recently hung again when the system was under heavy load. This
> most recent hang occured while playing for the first
> time, and produced a 'Zl' state in audacious instead of a D state.

Next time it happens please do

	echo t > /proc/sysrq-trigger
	dmesg -s 1000000 > foo

and send foo.
