Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262177AbTIMUHs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 16:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262178AbTIMUHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 16:07:47 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:28164 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S262177AbTIMUHp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 16:07:45 -0400
Date: Sat, 13 Sep 2003 22:07:43 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Dmitri Katchalov <dmitrik@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test5 atkbd.c: Unknown key (100% reproduceable)
Message-ID: <20030913220743.B3295@pclin040.win.tue.nl>
References: <1063443074.3f62da82a7e24@webmail.netregistry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1063443074.3f62da82a7e24@webmail.netregistry.net>; from dmitrik@users.sourceforge.net on Sat, Sep 13, 2003 at 06:51:14PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 13, 2003 at 06:51:14PM +1000, Dmitri Katchalov wrote:

> I'm consistently getting this error:
> 
> atkbd.c: Unknown key (set 2, scancode 0xab, on isa0060/serio0) pressed.
> This happens whenever I type 'f' in "<F7>usbdevfs". It then keeps 
> repeating the 'f' until I press another key. I first noticed it when 
> doing a search in mcedit but it also happens on command line and 
> everywhere. It does not matter if I type it slow of fast. If I type 
> less then the whole string (eg. "devf") the error does not occur but 
> the letter 'f' occasionally gets eaten away.
> 
> H/W: P4 (w/HT), ABIT IS7 M/B with Intel i865/ICH5 chipset, 
> bog-standard cheap PS/2 kbd.
> S/W: Debian mid-way between stable and testing, 2.6.0-test5 
> with SMP and preemptive, no extra tasks running (I can reproduce it at 
> the login prompt immediately after reboot).

Question 1: Does the error remain if you switch off preemptive?

Question 2: Can you enable DEBUG in i8042.c, repeat the error
and mail me the resulting output?

Andries

aeb@cwi.nl

