Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266096AbUJBNXW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266096AbUJBNXW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 09:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266116AbUJBNXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 09:23:22 -0400
Received: from [80.227.59.61] ([80.227.59.61]:9612 "EHLO HasBox.COM")
	by vger.kernel.org with ESMTP id S266096AbUJBNXU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 09:23:20 -0400
Message-ID: <415EABA2.6010605@0Bits.COM>
Date: Sat, 02 Oct 2004 17:22:42 +0400
From: Mitch <Mitch@0Bits.COM>
User-Agent: Application 0.6+ (X11/20041001)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: pavel@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3 software suspend (pmdisk) stopped working 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't understand. The highmem issue was when resuming, not when
suspending ? My laptop doesn't suspend with -rc3. Please elaborate ?
What config do i change ? Remember i don't have ACPI, so unless pmdisk
supports APM BIOS poweroff, then -rc3 is useless to me.

Thanks
M
-------- Original Message --------
Subject: Re: 2.6.9-rc3 software suspend (pmdisk) stopped working
Date: Fri, 1 Oct 2004 15:40:05 +0200
From: Pavel Machek <pavel@suse.cz>
To: Mitch DSouza <Mitch@0Bits.COM>
CC: linux-kernel@vger.kernel.org
References: <415D311E.2050006@0Bits.COM>

Hi!

> I thought i was going barmy. I've reverted back to -rc2 which
> pmdisk works flawlessly on my laptop.

Actually problem turned out to be in highmem. Unless you
are using highmem, -rc3 should work. You'll need to change config if
switching from pmdisk to swsusp...

				Pavel
