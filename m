Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261332AbUJ3Vdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbUJ3Vdj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 17:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261335AbUJ3Vdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 17:33:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:42463 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261332AbUJ3Vdg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 17:33:36 -0400
Date: Sat, 30 Oct 2004 14:31:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>,
       Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: No PS2 with ACPI [was Re: 2.6.10-rc1-mm2]
Message-Id: <20041030143132.5f20d048.akpm@osdl.org>
In-Reply-To: <1099149503l.23066l.0l@werewolf.able.es>
References: <20041029014930.21ed5b9a.akpm@osdl.org>
	<1099149503l.23066l.0l@werewolf.able.es>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J.A. Magallon" <jamagallon@able.es> wrote:
>
> 
> On 2004.10.29, Andrew Morton wrote:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm2/
> > 
> > 
> 
> Here we go again...

Perhaps Dmitry and Vojtech can help.

> With normal boot, I have no kbd nor mouse (both PS2).
> 2.6.9-mm1 detects them correctly:
> 
> mice: PS/2 mouse device common for all mice
> input: AT Translated Set 2 keyboard on isa0060/serio0
> input: PS2++ Logitech <NULL> on isa0060/serio1
> 
> 2.6.10-rc1-mm2 misses the two 'input' lines, I just get the 'mice:' one.
> 
> Booting with i8042.noacpi makes them work again.
> 
> BTW, what is that <NULL> ? 
> I don't have the full logs, but 2.6.9-rc2-mm2 told 'Mouse',and
> the next I have is -rc3-mm3 that says '<NULL>'.
> 
> TIA
> 
> --
> J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
> werewolf!able!es                         \         It's better when it's free
> Mandrakelinux release 10.1 (Community) for i586
> Linux 2.6.9-jam1 (gcc 3.4.1 (Mandrakelinux 10.1 3.4.1-4mdk)) #6
> 
> 
