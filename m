Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751482AbWIMBnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbWIMBnS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 21:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbWIMBnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 21:43:18 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:42576 "EHLO
	asav12.insightbb.com") by vger.kernel.org with ESMTP
	id S1751482AbWIMBnR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 21:43:17 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AR4FAAb9BkWBTooWLA
From: Dmitry Torokhov <dtor@insightbb.com>
To: Piotr Gluszenia Slawinski <curious@zjeby.dyndns.org>
Subject: Re: thinkpad 360Cs keyboard problem
Date: Tue, 12 Sep 2006 21:43:15 -0400
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.63.0609100119180.2685@Jerry.zjeby.dyndns.org> <d120d5000609121012o684a098bx6bc2d497a17b1421@mail.gmail.com> <Pine.LNX.4.63.0609121950381.2685@Jerry.zjeby.dyndns.org>
In-Reply-To: <Pine.LNX.4.63.0609121950381.2685@Jerry.zjeby.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200609122143.15814.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 September 2006 17:21, Piotr Gluszenia Slawinski wrote:
> On Tue, 12 Sep 2006, Dmitry Torokhov wrote:
> 
> > On 9/12/06, Piotr Gluszenia Slawinski <curious@zjeby.dyndns.org> wrote:
> >>  On Tue, 12 Sep 2006, Dmitry Torokhov wrote:
> >> 
> >> >  On 9/11/06, Piotr Gluszenia Slawinski <curious@zjeby.dyndns.org> wrote:
> >> 
> >> > >   kernel boots up fine, but keyboard is totally messed up,
> >> > >   and locks up after some tries of use.
> >> > 
> >> >  Could you try describing the exact issues with the keyboard? Missing
> >> >  keypresses, wrong keys reported, etc?
> >>
> >>  with prink enabled it prints series of 'unknown scancode'
> >>  and keys are randomly messed up, and it changes, so like pressing b
> >>  results with n, then space, then nothing at all.
> >>  after some tries keyboard locks up completely.
> >> 
> >
> > Are you loading a custom keymap by any chance? Could I please see
> > dmesg with "i8042.debug log_buf_len=131072"?
> 
> no custom keymaps . init=/bin/bash :d
> uhm, i don't get what you mean by this dmesg syntax :o

These were kernel boot options. If you let the system boot normally
so that syslog is running I'd expect debug messages end somewhere
(like in /var/log/messages) so you could reboot and send me that file.

> i should probably attach serial conole and send you whole output,
> as now (as keyboard is unuseable) i can't scroll screen.
> 
> btw. serio: i8042 KBD port at 0x60,0x64 irq 1
> is found.
> also
> input: AT Raw Set 2 keyboard as /class/input/input1
> is reported
> 

It could be that it lies about being in raw mode and actually is in
translated mode.

-- 
Dmitry
