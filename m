Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262589AbUCRMmU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 07:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262591AbUCRMmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 07:42:20 -0500
Received: from main.gmane.org ([80.91.224.249]:36754 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262589AbUCRMmT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 07:42:19 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Patrick Beard" <patrick@scotcomms.co.uk>
Subject: Kernel 2.6.3 i810fb Grub Boot Loader
Date: Thu, 18 Mar 2004 12:42:14 -0000
Message-ID: <c3c5f7$19a$1@sea.gmane.org>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: gateway.scotcomms.co.uk
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Not sure if this is a i810fb issue or not (appologies if its not)

I've been using the i810fb in kernel 2.6.x with no problems on Debian
sarge.
Below is the append line I used in Lilo;
video=i810fb:vram:2,xres:1024,yres:768,bpp:16,hsync1:30,hsync2:55,vsync1
:50,vsync2:85,accel,mtrr
(note: The hsync and vsync are not the actual values. I'm not at my
system and can't remember what they are.)

Last night I switched from using lilo to grub. everything went ok. I
added the above to my grub config and rebooted. The console is fine
except for one thing. I get what appears to be a block cursor in the
middle of the screen. When I log in, the cursor stays in the middle of
the screen until I hit enter, it then jumps to the bottom left. From
then on it sort of follows what I type but not quite, it remains
somewhat out of sync with where the cursor should actually be. I tried
using 'hwcur' on the above but this didn't do anything.

I'm using the same parameters that I used with lilo, yet I never had
this issue.

Apart from switching back to lilo, is there anything I can try to
resolve this?

TIA

Paddy



