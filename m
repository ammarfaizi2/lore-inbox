Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161038AbWBNUdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161038AbWBNUdU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 15:33:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161046AbWBNUdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 15:33:20 -0500
Received: from nproxy.gmail.com ([64.233.182.203]:41529 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161038AbWBNUdT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 15:33:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=iJnhMEE0BfBuHHlzWM0qKovB6pFzq1C6IPF8TBMx85Pgb3Hhvi1gLSPhXgH6/xRw/cY9uPjgEK9HJELN1tY5ssyBwJ+jbQJF2wG7ZfRoWw5JRj3zlD7W5sRLZQZ7Su3aDJ6ntqP4aLWjRD3p/Ld8DRjlsWoo1ucZIme63WljcDo=
Message-ID: <9871ee5f0602141233t3cf11775lcb6351f31d4f377e@mail.gmail.com>
Date: Tue, 14 Feb 2006 15:33:17 -0500
From: Timothy Miller <theosib@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: HELP: Problem with radeonfb setting wrong resolution
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I humbly apologize if it is inappropriate for me to post this question
here.  I'm not subscribed, and I haven't been in a while.  I've
googled around for answers to this, but I don't find anything that
directly addresses the issue I'm seeing.  Please cc me.

I'm installing a new Gentoo box, and I have configured the
2.6.12-gentoo-r6 kernel.

Here's what I have enabled:

+ Support for framebuffer devices
+ ATI Radeon display support
+ DDC/I2C for ATI Radeon support
+ Lots of debug output from Radeon drive
+ VGA text console
+ Framebuffer Console support

In the grub.conf file, I have this at the end of the kernel line:

video=radeonfb:1024x768

When booting up, radeonfb finds the device (A Radeon 7000 PCI card),
the monitor flickers for a second, and then what I get is a 640x480
screen, but the kernel seems to think it's 1024x768, because text goes
off the screen.

I've googled for this, but what I find is old stuff where people are
complaining about seeing a higher resolution than the one they asked
for.  I'm getting a LOWER resolution.

I can't figure out what I'm doing wrong, but there are no kernel error
messages that tell me anything has gone wrong.

Can anyone help me figure out what I'm doing wrong here?  BTW, the
monitor is a 19" NEC.  No chance that the monitor reports via DDC that
it can't do 1024x768.

Thanks.
