Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161265AbVIPS5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161265AbVIPS5S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 14:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161266AbVIPS5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 14:57:18 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:1607 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161265AbVIPS5R convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 14:57:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=iLkmN/Pruhv7Q+CN/ISp3PxIwF/ZVAWg4U9AddCSvJ9bX4z7zhQGFzJRGfccppq0dAcxTE1QRR2jnUCfkAmSovamToeWfAbGwBhd21XcAAdRqEU2eIbxOzlKo+JJgHeSemWlme3pUOoazWv6pCGTAeol9GPifagbRLAW7Fk6Tu8=
Message-ID: <4746469c0509161157bc762bc@mail.gmail.com>
Date: Fri, 16 Sep 2005 11:57:16 -0700
From: Mike Mohr <akihana@gmail.com>
Reply-To: akihana@gmail.com
To: linux-kernel@vger.kernel.org
Subject: Reboot & ACPI suspend Laptop display initialization
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There seems to be an issue with the VESA driver for my laptop's video
card.  I can install any version of the kernel (tested with
2.4.{23,24}, 2.4.31, and various 2.6.XX > 2.6.8) and the system turns
on and boots fine.  However, if I go into suspend to ram (which I
think is ACPI S3) where the display is turned off -or- I reboot
without shutting down first, the display is not re-initialized.

The system seems to come back on into a semi-usable state (i.e. if I
reboot the kernel seems to boot and the system comes up), but the
display remains solid black, so I have not been able to verify this. 
Come to think of it, I could probably connect the laptop up to my home
network and SSH into it after this happens, but I haven't yet done so.

My laptop is a Toshiba Satellite 1800 S207 with a Trident XPAi1 video
card.  If I use the tridentfb driver (at least as of kernel 2.4) at
boot time, the screen turns various shades of gold immediately after
the kernel loads. Can someone help me debug this issue so that a fix
can be written?  The problem happens even with a pristine installation
of Slackware 10.2 with the default bare 2.4.31 kernel.

TIA

Mike
