Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266116AbUHFWG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266116AbUHFWG7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 18:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268316AbUHFWG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 18:06:59 -0400
Received: from relay-av.club-internet.fr ([194.158.96.107]:38793 "EHLO
	relay-av.club-internet.fr") by vger.kernel.org with ESMTP
	id S266116AbUHFWG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 18:06:58 -0400
From: Yapo Sebastien <sebastien.yapo@e-neyret.com>
Organization: e-Neyret
To: linux-kernel@vger.kernel.org
Subject: Re: disabling all video
Date: Sat, 7 Aug 2004 00:08:42 +0000
User-Agent: KMail/1.6.1
References: <4113E0FE.1040506@networkstreaming.com>
In-Reply-To: <4113E0FE.1040506@networkstreaming.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200408070008.42519.sebastien.yapo@e-neyret.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Question: I would like the kernel not to use any of the video hardware
> on the machine.  Is there any run-time kernel parameter I can pass to
> disable all video?  (I tried console= to direct output to the serial
> port, but ttys were still using the vga hardware.)  My video card is
> built onto the mother board, and there is no way I see to disable it
> from the BIOS.
>
Remove "if EMBEDDED" in the VT and VT_CONSOLE section of drivers/char/Kconfig 
then reconfigure your kernel.
You should find the old VT options in Device Drivers  -> Character devices

Regards

Sebastien
