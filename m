Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268246AbUIPU53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268246AbUIPU53 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 16:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268253AbUIPU53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 16:57:29 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:19118 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S268246AbUIPU51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 16:57:27 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: very strange issues on x86-64 with console switching
Date: Thu, 16 Sep 2004 22:59:26 +0200
User-Agent: KMail/1.6.2
Cc: kernel list <linux-kernel@vger.kernel.org>, vojtech@suse.cz
References: <20040916192622.GA3713@elf.ucw.cz> <20040916193014.GA997@elf.ucw.cz>
In-Reply-To: <20040916193014.GA997@elf.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200409162259.26543.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 of September 2004 21:30, Pavel Machek wrote:
> Hi!
> 
> > I do not understand what went wrong, but (after swsusp?) I now can
> > only console switch once. After console switch "alt" key is forgotten
> > and I have to release it and press it again if I want to switch to
> > other console... Strange.
> 
> Okay, it happens on fresh boot, too. Only remotely strange thing I'm
> doing here is load of keymap that swaps ctrl and capslock. Linux
> 2.6.9-rc1-mm5. Problem is there only in 64-bit mode.

It didn't happen to me, but on 2.6.9-rc1-mm5 I had the problem that 
Ctrl+Alt+Del apparently did not work after "init 5" and Ctrl+Alt+F[1-9].  
Whatever I did, I couldn't reboot the machine this way from any console (of 
course 'reboot" worked as usual).

Now I'm running 2.6.9-rc2-mm1 and it works as expected (w.r.t. Ctrl+Alt+Del at 
least), so I'd suggest you to try this one.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
