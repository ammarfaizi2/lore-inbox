Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136477AbRD3H6v>; Mon, 30 Apr 2001 03:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136478AbRD3H6m>; Mon, 30 Apr 2001 03:58:42 -0400
Received: from smtp3.xs4all.nl ([194.109.127.132]:61451 "EHLO smtp3.xs4all.nl")
	by vger.kernel.org with ESMTP id <S136477AbRD3H6i>;
	Mon, 30 Apr 2001 03:58:38 -0400
From: thunder7@xs4all.nl
Date: Mon, 30 Apr 2001 07:40:27 +0200
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [lkml]Re: Mounting an external USB host-powered ZIP 250 drive hangs in mount()
Message-ID: <20010430074027.A3914@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
In-Reply-To: <20010429075856.A821@middle.of.nowhere> <20010429211346.A8349@one-eyed-alien.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20010429211346.A8349@one-eyed-alien.net>; from mdharm-kernel@one-eyed-alien.net on Sun, Apr 29, 2001 at 09:13:46PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 29, 2001 at 09:13:46PM -0700, Matthew Dharm wrote:
> I see you're using the alternate uhci driver... are hte results the same
> with the other UHCI driver?

I have read in the help-files that that was the one to use on this
VIA694 motherboard.
> 
> Can you turn on usb mass storage verbose debuggig (compile option) and then
> send me the logs?
> 
I'll do that. In the meantime, 2.4.4 does work - so it's something in
the ac12 kernel that prevents it from working. Unfortunately I can't try
ac13 or ac14, since the pcnet32 code doesn't compile in those.

Jurriaan
-- 
And money rides while people crawl
And another quiet night goes by
	Oysterband - Another quiet night in England
GNU/Linux 2.4.4 SMP/ReiserFS 2x1743 bogomips load av: 0.27 0.06 0.02
