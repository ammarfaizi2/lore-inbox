Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283048AbRK1N5N>; Wed, 28 Nov 2001 08:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282145AbRK1N5B>; Wed, 28 Nov 2001 08:57:01 -0500
Received: from junk.nocrew.org ([212.73.17.42]:17331 "EHLO junk.nocrew.org")
	by vger.kernel.org with ESMTP id <S282142AbRK1N4v>;
	Wed, 28 Nov 2001 08:56:51 -0500
To: root@chaos.analogic.com
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Magic Lantern
In-Reply-To: <Pine.LNX.3.95.1011128083018.10601A-100000@chaos.analogic.com>
From: Lars Brinkhoff <lars.spam@nocrew.org>
Organization: nocrew
Date: 28 Nov 2001 14:56:41 +0100
In-Reply-To: <Pine.LNX.3.95.1011128083018.10601A-100000@chaos.analogic.com>
Message-ID: <85adx7vw12.fsf@junk.nocrew.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" <root@chaos.analogic.com> writes:
> Are there currently any kernel hooks to support Magic Lantern?
> Basically, a "tee" to capture all network packets and pass them
> on to a filtering task without affecting normal network activity.
> It's like `tcpdump`, but allows packets to be inserted into the
> output queue as well without affecting normal network activity.

The af_packet module can read and write raw ethernet frames.

-- 
Lars Brinkhoff          http://lars.nocrew.org/     Linux, GCC, PDP-10
Brinkhoff Consulting    http://www.brinkhoff.se/    programming
