Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262228AbVAJMq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbVAJMq5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 07:46:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262230AbVAJMq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 07:46:57 -0500
Received: from rproxy.gmail.com ([64.233.170.196]:35157 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262228AbVAJMqy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 07:46:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=I9Y8jZZ/gLimGV07kr5h7tCVLEAlou0ggCbtrm+F7mJLsTPdql9DflK7LMg3WtaIF2DP4b520PNkYtDYirGOJ8GD/rezdtLf+3WTPR+Whp/Pf+/yO1/bJZjtw3KOV1r5C1njtIGKDNP890VsZTyQCzIbUk16YFuJhiVEtsw/CiU=
Message-ID: <884a349a050110044654d75f7b@mail.gmail.com>
Date: Mon, 10 Jan 2005 13:46:53 +0100
From: Roseline Bonchamp <roseline.bonchamp@gmail.com>
Reply-To: Roseline Bonchamp <roseline.bonchamp@gmail.com>
To: linux-usb-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: USB problem with a mass storage device on 2.6.10
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a PQI 1GB Intelligent Stick, which does'nt work most of the
time on 2.6.10 (sometime when I plug/unplug it does work, but most of
the time it does'nt)

When it does not work, I see this when I plug it:

kernel: usb 1-3: new high speed USB device using ehci_hcd and address 6
kernel: usb 3-1: new full speed USB device using uhci_hcd and address 4
kernel: usb 3-1: new full speed USB device using uhci_hcd and address 5

When it does work, I only see the first one (high speed), and then USB
mass storage stuff.

On kernel 2.6.9 it does work, but seems to produce a kernel crash (log
attached) (but I still can use it and mount it)

I tried on a knoppix 3.6 (2.6.7, not vanilla) kernel, and it seems to work too.

Even with 2.6.10 I have no problem with some other USB mass storage devices.

I already did a post about this, but the subject of the mail was wrong
(sorry), and it was not mailed to linux-usb:
http://www.ussg.iu.edu/hypermail/linux/kernel/0501.1/0371.html

Regards,
