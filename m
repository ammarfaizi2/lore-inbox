Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262633AbTI1RSe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 13:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262622AbTI1RSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 13:18:34 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:28683 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S262633AbTI1RSd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 13:18:33 -0400
From: Michael Frank <mhf@linuxmail.org>
To: Russell King <rmk@arm.linux.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: CONFIG_I8042
Date: Mon, 29 Sep 2003 01:16:11 +0800
User-Agent: KMail/1.5.2
Cc: Vojtech Pavlik <vojtech@suse.cz>
References: <20030928160314.A1428@flint.arm.linux.org.uk>
In-Reply-To: <20030928160314.A1428@flint.arm.linux.org.uk>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309290116.11143.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 28 September 2003 23:03, Russell King wrote:
> How can we turn this option off on non-x86 and without selecting
> CONFIG_EMBEDDED?  It seems that as the configuration files stand,
> it is impossible to deselect this option:
> 
> config SERIO_I8042
>         tristate "i8042 PC Keyboard controller" if EMBEDDED || !X86
>         default y
>         select SERIO
> 
> It seems that in menuconfig, it isn't possible to change this option
> either:
> 
>   x x            --- Serial i/o support                                    x x
>   x x            --- i8042 PC Keyboard controller                          x x
>   x x            <M> Serial port line discipline                           x x
> 
> Maybe "!X86" doesn't mean "not X86 architectures" when it isn't
> defined?

Yeah, to make X86 under-donkey proof...

One can't make i8042 a module either.

Michael

