Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264009AbTDJI7d (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 04:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264012AbTDJI7d (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 04:59:33 -0400
Received: from adsl-63-198-217-24.dsl.snfc21.pacbell.net ([63.198.217.24]:58767
	"EHLO cygne") by vger.kernel.org with ESMTP id S264009AbTDJI7c (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 04:59:32 -0400
Message-ID: <39101.62.253.198.200.1049947940.squirrel@www.masroudeau.com>
Date: Thu, 10 Apr 2003 05:12:20 +0100 (BST)
Subject: RE: keyboard problem
From: etienne.lorrain@masroudeau.com
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.0
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I try to compile the linux kernel 2.4.20 on the gentoo 1.4rc3 and i can't
> get the ps2 keyboard working :
>
> dmesg gives me the following (sorry, full dump follows ;-).
>
> I tried several configs, with and without APIC (i found a few messages on
> the subject), but i really can't get it working. I got into the box
> activating sshd and logging from network, but this is not very pratical
> ;-)
> The target machine is a Asus Terminator P4 533, specifications are
> available here : http://www.asus.com/prog/spec.asp?m=Terminator%20P4%20533
> Chipset is a SIS651.
>
> Does someone have a clue ?
>
> Thanks in advance !

 Just my €0.02 :
 does it work with other kernel version?
 If not, you may try another bootloader, let's say Gujin:
 It manages the keyboard chip differently - it opens A20 and reset
 the keyboard interface itself if needed.
 May work, may not work, YMMV...

 Note also your startup lines:
|agpgart: Maximum main memory to use for agp memory: 199M
|agpgart: Unsupported SiS chipset (device id: 0651), you might want to try
|agp_try_unsupported=1.
|agpgart: no supported devices found.

http://sourceforge.net/projects/gujin

 Etienne.

P.S. Nice place it is, Limoges.
