Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265303AbUBANtp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 08:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265299AbUBANtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 08:49:45 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:50305 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S265303AbUBANtn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 08:49:43 -0500
Date: Sun, 1 Feb 2004 14:50:01 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: 2.6 input drivers FAQ
Message-ID: <20040201135001.GA1804@ucw.cz>
References: <20040201100644.GA2201@ucw.cz> <20040201141516.A28045@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040201141516.A28045@pclin040.win.tue.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 01, 2004 at 02:15:16PM +0100, Andries Brouwer wrote:

> On Sun, Feb 01, 2004 at 11:06:44AM +0100, Vojtech Pavlik wrote:
> 
> > Common problems and solutions with 2.6 input drivers:
> 
> Good!
> 
> > Get a recent version of kbd-utils, and recompile on a 2.6 kernel.
> 
> Is there something called kbd-utils?
> I maintain the kbd package. Maybe recent versions will work
> on both 2.4 and 2.6, regardless where they were compiled.
> 
> (Send bug reports to aeb@cwi.nl)

Sorry. I was typing that from memory. I'll fix it. Btw, could you make
the kbd package accept scancodes in the 0x80-0xff range (same as e000 to
e07f), if it is not yet there? And how about scancodes in the
0x100-0x1ff range? Will those work?

One more question: Will kbdrate work properly (use ioctls) when compiled
on a 2.6 kernels?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
