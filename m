Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbTK3Xjk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 18:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbTK3Xjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 18:39:40 -0500
Received: from gprs149-102.eurotel.cz ([160.218.149.102]:11136 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261909AbTK3Xjj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 18:39:39 -0500
Date: Sun, 30 Nov 2003 20:18:35 +0100
From: Pavel Machek <pavel@ucw.cz>
To: linux-kernel@vger.kernel.org
Cc: rene@rene-engelhard.de
Subject: Re: 2.6.0-test11: Mouse breaks after Suspend-to-RAM
Message-ID: <20031130191834.GA188@elf.ucw.cz>
References: <20031127125344.GA2606@rene-engelhard.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031127125344.GA2606@rene-engelhard.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

> [ please Cc: me as I am not on linux-kernel ]
> 
> Hi,
> 
> Suspend-to-Dsk via Software Suspend seems to work fine -- however,
> Suspend-to-RAM doesn't.
> 
> When I echo 3 > /proc/acpi/sleep it goes into sleep mode as it should
> and it awakes as it should. However, my mouse in X then is really
> confused and does not do what I want it to do.
> 
> On the tthy then there is written:
> 
> psmouse.c: Wheel Mouse at isa0060/serio1/input0 lost synchronization,
> throwing 2 bytes away.
> 
> I need to reboot :/
> 
> This "mouse" is a trackpad if that helps..

I'm working on that, there are some 'bigdiffs' floating around, but
you should probably wait until it gets stable...
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
