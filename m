Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266057AbTGIQdV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 12:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266063AbTGIQdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 12:33:21 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:20099 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S266057AbTGIQdU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 12:33:20 -0400
X-AuthUser: davidel@xmailserver.org
Date: Wed, 9 Jul 2003 09:40:24 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Daniel <daniel@hawton.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ACPI status in 2.5.x/2.6.0
In-Reply-To: <3F0BD5D1.2010801@hawton.org>
Message-ID: <Pine.LNX.4.55.0307090938160.4625@bigblue.dev.mcafeelabs.com>
References: <3F0BD5D1.2010801@hawton.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jul 2003, Daniel wrote:

> I have a Compaq Laptop (*shiver*) and present distro versions featuring
> the 2.4.x kernel seem to panic or lock on bootup on my laptop.  I was
> wondering if ACPI was better supported in the 2.5.x kernel branch/2.6.0
> pre-kernel.  Any advice would be greatly appreciated.
>
> It would lock when attempting to read my partition table on device 'hda'
> (my hard disk), or would panic when attempting to initalize the USB device.

If it uses a SiS650 chipset you can try this :

http://www.xmailserver.org/linux-patches/misc.html#SiSRt

Even if I am not much confident about success in your case. Also, I
believe Alan was working of fixing ACPI for SiS. You might want to check.



- Davide

