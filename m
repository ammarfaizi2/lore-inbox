Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932395AbVJDMEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbVJDMEg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 08:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbVJDMEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 08:04:36 -0400
Received: from mail.sysgo.com ([62.8.134.5]:48326 "EHLO mail.sysgo.com")
	by vger.kernel.org with ESMTP id S932395AbVJDMEf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 08:04:35 -0400
From: Rolf Offermanns <roffermanns@sysgo.com>
Subject: Re: thinkpad suspend to ram and backlight
To: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Date: Tue, 04 Oct 2005 14:04:32 +0200
References: <20051002175703.GA3141@elf.ucw.cz> <43410149.9070007@suse.de> <20051004114411.GC17458@elf.ucw.cz>
Organization: SYSGO AG
User-Agent: KNode/0.9.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <20051004120432.6366F1A7F93@donald.sysgo.com>
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.2-8; AVE: 6.32.0.6; VDF: 6.32.0.57; host: mailgate2.sysgo.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

> Hi!
> 
>> > When I suspend to RAM on x32, backlight is not turned off. (And, IIRC,
>> > video chips is not turned off, too). Unfortunately, backlight is not
>> > turned even when lid is closed. I know some patches were floating
>> > around to solve that... but I can't find them now. Any ideas?
>> 
>> Which framebuffer driver? Vesafb works for Timo, at least he did not
>> complain lately ;-)
> 
> I really want radeonfb... I can try vesa, but long term this needs
> solutions in radeon.
> Pavel
> 
You could use radeontool [1] as a temporary solution.

-Rolf

[1] http://fdd.com/software/radeon/

