Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262008AbUEQSK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbUEQSK3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 14:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbUEQSK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 14:10:29 -0400
Received: from smtp806.mail.sc5.yahoo.com ([66.163.168.185]:17489 "HELO
	smtp806.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262008AbUEQSKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 14:10:21 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Scroll wheel on PS/2 Logitech MouseMan Wheel no longer works (was Re: 2.6.6-mm3)
Date: Mon, 17 May 2004 13:10:15 -0500
User-Agent: KMail/1.6.2
Cc: Sean Neakums <sneakums@zork.net>, Andrew Morton <akpm@osdl.org>,
       vojtech@suse.cz
References: <20040516025514.3fe93f0c.akpm@osdl.org> <6u3c5zkxoo.fsf@zork.zork.net>
In-Reply-To: <6u3c5zkxoo.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405171310.16761.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 17 May 2004 08:09 am, Sean Neakums wrote:
> Andrew Morton <akpm@osdl.org> writes:
> 
> >  bk-input.patch
> 
> I'm guessing this patch contains the changes responsible.
> 
> As with 2.6.6-mm2 (and before, from a quick grep of
> /var/log/messages), the mouse is detected as
> 
>   mice: PS/2 mouse device common for all mice
>   serio: i8042 AUX port at 0x60,0x64 irq 12
>   input: ImExPS/2 Logitech Wheel Mouse on isa0060/serio1
> 
> but moving the wheel causes the pointer to make large jumps toward the
> top-right corner.
> 
> When I boot with psmouse.proto=imps, it is detected as below and works
> as before.
> 
>   mice: PS/2 mouse device common for all mice
>   serio: i8042 AUX port at 0x60,0x64 irq 12
>   input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
> 
> In case it's relevant, the mouse is connected through a KVM switch.

My Intellimouse Explorer (USB) wheel seems to be working fine so mousedev
changes should be ok...  Would you mind compiling evbug module and telling
me what events the wheel generates?

Thanks! 

-- 
Dmitry
