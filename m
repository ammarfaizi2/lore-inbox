Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932736AbWAKABy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932736AbWAKABy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 19:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932739AbWAKABy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 19:01:54 -0500
Received: from sith.mimuw.edu.pl ([193.0.96.4]:33296 "EHLO sith.mimuw.edu.pl")
	by vger.kernel.org with ESMTP id S932736AbWAKABx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 19:01:53 -0500
Date: Wed, 11 Jan 2006 01:01:51 +0100
From: Jan Rekorajski <baggins@sith.mimuw.edu.pl>
To: linux-kernel@vger.kernel.org
Cc: Vojtech Pavlik <vojtech@suse.cz>, Alan Stern <stern@rowland.harvard.edu>,
       Martin Bretschneider <mailing-lists-mmv@bretschneidernet.de>,
       "dtor_core @ ameritech. net Jan Engelhardt" <jengelh@linux01.gwdg.de>,
       linux-usb-devel@lists.sourceforge.net, Greg KH <gregkh@suse.de>,
       Leonid <nouser@lpetrov.net>
Subject: Re: PROBLEM: PS/2 keyboard does not work with 2.6.15
Message-ID: <20060111000151.GA5712@sith.mimuw.edu.pl>
Mail-Followup-To: Jan Rekorajski <baggins@sith.mimuw.edu.pl>,
	linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>,
	Alan Stern <stern@rowland.harvard.edu>,
	Martin Bretschneider <mailing-lists-mmv@bretschneidernet.de>,
	"dtor_core @ ameritech. net Jan Engelhardt" <jengelh@linux01.gwdg.de>,
	linux-usb-devel@lists.sourceforge.net, Greg KH <gregkh@suse.de>,
	Leonid <nouser@lpetrov.net>
References: <20060110074336.GA7462@suse.cz> <Pine.LNX.4.44L0.0601101008440.5060-100000@iolanthe.rowland.org> <20060110152807.GB22371@suse.cz> <d120d5000601100737r7b1e12edy6d4eedc4b12960fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d120d5000601100737r7b1e12edy6d4eedc4b12960fc@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-Operating-System: Linux 2.6.14.6 x86_64
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jan 2006, Dmitry Torokhov wrote:

> We'll just have to wait for another report. "Sluggish typing" report
> looks promising.

With 2.6.14.6:

serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1

and my keyboard works.

with 2.6.15:

i8042.c: Can't read CTR while initializing i8042.

and no PS/2 keyboard.

This happens on Dell Precision 380, x86_64 kernel with SMP/HT, no options
on kernel command line, same kernel .config (modulo make oldconfig).
I tried all solutions I found on google, none works (beside connecting
USB keyboard or disabling USB in BIOS).

Jan
-- 
Jan Rêkorajski            |  ALL SUSPECTS ARE GUILTY. PERIOD!
baggins<at>mimuw.edu.pl   |  OTHERWISE THEY WOULDN'T BE SUSPECTS, WOULD THEY?
BOFH, MANIAC              |                   -- TROOPS by Kevin Rubio
