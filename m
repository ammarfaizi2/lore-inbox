Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267892AbRGVEAM>; Sun, 22 Jul 2001 00:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267891AbRGVEAC>; Sun, 22 Jul 2001 00:00:02 -0400
Received: from marine.sonic.net ([208.201.224.37]:5498 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S267890AbRGVD7w>;
	Sat, 21 Jul 2001 23:59:52 -0400
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Sat, 21 Jul 2001 20:59:45 -0700
From: Mike Castle <dalgoda@ix.netcom.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Why Plan 9 C compilers don't have asm("")
Message-ID: <20010721205945.C5835@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0107212017470.6166-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


Why do I feel like I just read a description on the various real-mode x86
memory models?

mrc

On Sat, Jul 21, 2001 at 08:43:43PM -0700, Linus Torvalds wrote:
> Sure, you could sometimes get the slower case: more than a 2MB offset
> within a module, so that you'd have to use the trampoline, or if you're
> lazy and don't update the headers for dynamically linked libraries. But
> even then there would be the potential for icache win. And you could
> always have a "-mlarge-model" compiler option for those cases, so if you
> notice that you lose on this optimization, you just disable it.

-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
