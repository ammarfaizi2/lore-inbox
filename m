Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266301AbRGFIiF>; Fri, 6 Jul 2001 04:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266303AbRGFIhz>; Fri, 6 Jul 2001 04:37:55 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:35600 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S266301AbRGFIhp>;
	Fri, 6 Jul 2001 04:37:45 -0400
Date: Fri, 6 Jul 2001 02:38:35 -0600
From: Cort Dougan <cort@fsmlabs.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why Plan 9 C compilers don't have asm("")
Message-ID: <20010706023835.A5224@ftsoj.fsmlabs.com>
In-Reply-To: <200107040337.XAA00376@smarty.smart.net> <20010703233605.A1244@zalem.puupuu.org> <20010704002436.C1294@ftsoj.fsmlabs.com> <9hvjd4$1ok$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <9hvjd4$1ok$1@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Jul 04, 2001 at 05:22:44PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm talking about _modern_ processors, not processors that dominate the
modern age.  This isn't x86.  I don't believe that even aggressive
re-ordering will cause a serious hit in performance on function calls.
Unconditional branches are definitely predictable so icache pre-fetches are
not more complicated that straight-line code.

Measurement is more important, though.  I've rejected a number of
optimizations from people (including many of my own) that were "obvious
enhancements" because of what they showed in real-world measurements.  If
it doesn't run faster, despite the theory being "right", it's worthless.
