Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268577AbRHFPqS>; Mon, 6 Aug 2001 11:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268674AbRHFPqH>; Mon, 6 Aug 2001 11:46:07 -0400
Received: from [64.38.173.150] ([64.38.173.150]:37641 "EHLO chicago.cheek.com")
	by vger.kernel.org with ESMTP id <S268577AbRHFPp6>;
	Mon, 6 Aug 2001 11:45:58 -0400
Date: Mon, 6 Aug 2001 08:48:22 -0700 (PDT)
From: Joseph Cheek <joseph@cheek.com>
To: Andrey Savochkin <saw@saw.sw.com.sg>
cc: Colin Walters <walters@cis.ohio-state.edu>, linux-kernel@vger.kernel.org
Subject: Re: eepro100 (PCI ID 82820) lockups/failure
In-Reply-To: <20010806022727.A25793@saw.sw.com.sg>
Message-ID: <Pine.LNX.4.10.10108060846230.14815-100000@chicago.cheek.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i applied the usleep(1) patch and i still get lockups on 2.4.7-ac5.  not
sure how i could get you the info you need, but i would certainly be
willing to help.

my machine locks hard before anything gets to syslog.

thanks!

joe

--
Joseph Cheek, CTO, Redmond Linux Corp.
joseph@redmondlinux.org, www.redmondlinux.org
Redmond Linux.  Linux is for everyone.

On Mon, 6 Aug 2001, Andrey Savochkin wrote:

> Someone who experiences such timeouts needs to figure out how much time it
> really can take before a command is accepted.
> Some time ago the timeout was increased by the factor of 10, and now the
> current timeout looks being insufficient.
> It might be a problem with the time of specific commands or specific chip
> revisions.
> Or some hardware is too clever and somehow optimizes those repeated read
> operations, so that they no longer take a fixed number of bus cycles.
> 
> In short, that patch isn't a real solution.
> If someone provides me with the information which commands times-out and how
> much time they really need, we could have a real solution.

