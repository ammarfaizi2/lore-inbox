Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275359AbTHIT0U (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 15:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275370AbTHIT0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 15:26:20 -0400
Received: from sinma-gmbh.17.mind.de ([212.21.92.17]:47364 "EHLO gw.enyo.de")
	by vger.kernel.org with ESMTP id S275359AbTHIT0T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 15:26:19 -0400
To: Andries Brouwer <aebr@win.tue.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-test3 and earlier] no keyboard
References: <87ptjebwb8.fsf@deneb.enyo.de>
	<20030809203852.A9000@pclin040.win.tue.nl>
From: Florian Weimer <fw@deneb.enyo.de>
Mail-Followup-To: Andries Brouwer <aebr@win.tue.nl>,
 linux-kernel@vger.kernel.org
Date: Sat, 09 Aug 2003 21:26:16 +0200
In-Reply-To: <20030809203852.A9000@pclin040.win.tue.nl> (Andries Brouwer's
 message of "Sat, 9 Aug 2003 20:38:52 +0200")
Message-ID: <874r0qaazr.fsf@deneb.enyo.de>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer <aebr@win.tue.nl> writes:

>> atkbd.c: Unknown key (set 0, scancode 0xed, on isa0060/serio0) pressed.          

> Set 0 is "impossible", certainly a bug.
> So what are the boot messages about the keyboard?

serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1

I hope these lines are the correct ones.
