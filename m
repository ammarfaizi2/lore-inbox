Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932611AbVLFPf4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932611AbVLFPf4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 10:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932605AbVLFPf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 10:35:56 -0500
Received: from [81.2.110.250] ([81.2.110.250]:24523 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S964986AbVLFPfz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 10:35:55 -0500
Subject: Re: Keyboard broken in 2.6.13.2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ben Greear <greearb@candelatech.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <43909451.20105@candelatech.com>
References: <43909451.20105@candelatech.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 03 Dec 2005 10:16:28 +0000
Message-Id: <1133604988.13652.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-12-02 at 10:37 -0800, Ben Greear wrote:
> I have a system with a super-micro P8SCI motherboard.
> 
> The default FC2 kernel (2.6.10-1.771_FC2smp) works fine, but
> when I try to boot a 2.6.13.2 kernel, I see this error:
> 
> i8042.c: Can't read CTR while initializing i8042
> 
> If I hit the keyboard early in the boot, the system will just reboot.
> 
> If I wait a bit, then it will boot to a prompt, but no keyboard input
> is accepted.

Fedora Core has a patch (which was rejected upstream) which
automatically fixes up problems with some BIOS USB emulation. On the
base kernel you need to specify "usb-handoff" on the command line at
boot. Another approach is to turn USB keyboard off in the BIOS.

Alan

