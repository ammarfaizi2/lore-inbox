Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270803AbTHAOw1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 10:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275227AbTHAOw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 10:52:27 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:14599 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S270803AbTHAOw0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 10:52:26 -0400
Date: Fri, 1 Aug 2003 16:52:23 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Jurgen Kramer <gtm.kramer@inter.nl.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1/2: keyboard funnies in textmode
Message-ID: <20030801145223.GA3308@win.tue.nl>
References: <1059747945.2809.2.camel@paragon.slim>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1059747945.2809.2.camel@paragon.slim>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 01, 2003 at 04:25:45PM +0200, Jurgen Kramer wrote:

> With both 2.6.0-test1 and test2 I am unable to use
> de pipe (|) key in textmode (??). When in X it works again.
> I have tested this on 2 machines. One machine is a laptop with Japanese
> keyboard the other a regular PC with wireless Logitech USB keyboard.
> 
> All the other keys seem to work properly...anyone else with this strange
> problem?

Can you give some details?

- When did it last work?
- What does it mean: "am unable to use"?
(Is the key ignored? Does the system crash? Do you get different keycodes?)
- What are the boot messages about the keyboard?

The pipe key is the same as the backslash key (say, on a US keyboard).
And there is some interesting confusion between Yen and Backslash
(since ASCII and JIS-Roman coincide, except in the yen and overbar
positions, where ASCII has backslash and tilde).
So, I am not surprised by weird things on a Japanese keyboard.

Do you use scancode Set 3?

Andries

