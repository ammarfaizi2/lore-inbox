Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbUJ3Pmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbUJ3Pmp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 11:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261284AbUJ3Pj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 11:39:27 -0400
Received: from smtp07.auna.com ([62.81.186.17]:1758 "EHLO smtp07.retemail.es")
	by vger.kernel.org with ESMTP id S261189AbUJ3PSY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 11:18:24 -0400
Date: Sat, 30 Oct 2004 15:18:23 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: No PS2 with ACPI [was Re: 2.6.10-rc1-mm2]
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
References: <20041029014930.21ed5b9a.akpm@osdl.org>
X-Mailer: Balsa 2.2.5
Message-Id: <1099149503l.23066l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004.10.29, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm2/
> 
> 

Here we go again...

With normal boot, I have no kbd nor mouse (both PS2).
2.6.9-mm1 detects them correctly:

mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: PS2++ Logitech <NULL> on isa0060/serio1

2.6.10-rc1-mm2 misses the two 'input' lines, I just get the 'mice:' one.

Booting with i8042.noacpi makes them work again.

BTW, what is that <NULL> ? 
I don't have the full logs, but 2.6.9-rc2-mm2 told 'Mouse',and
the next I have is -rc3-mm3 that says '<NULL>'.

TIA

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.1 (Community) for i586
Linux 2.6.9-jam1 (gcc 3.4.1 (Mandrakelinux 10.1 3.4.1-4mdk)) #6




